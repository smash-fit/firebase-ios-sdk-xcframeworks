#!/bin/bash

xcframework_name () {
    # Filter out path and extension to get the framework name
    # Ex. xcframework_name "FirebaseFirestore/leveldb-library.xcframework" = "leveldb-library"
    echo $1 | sed -E 's/.*\/|\.xcframework|\.xcframework\.zip//g'
}

resource_name () {
    # Filter out path to get the file name
    # Ex. file_name "FirebaseFirestore/Resources/gRPCCertificates-Cpp.bundle" = "gRPCCertificates-Cpp.bundle"
    echo $1 | sed -E 's/.*\///g'
}

library_name () {
    # Filter out path to get the folder name
    # Ex. library_name "FirebaseAnalytics/FirebaseInstallations.xcframework" = "FirebaseAnalytics"
    echo $1 | sed -E 's/\/|\/.*\.xcframework|\/.*\.xcframework\.zip//g'
}

excludes () {
    # Files other than xcframeworks will not be included in the package
    echo "$1" | grep -v -E ".xcframework"
}

trim_empty_lines () {
    # Delete all empty lines in a file
    sed -i '' '/^$/d' $1
}

template_replace () {
    local file=$(cat $1)
    # Replace the template with the contents of the replacement file
    local result=${file//"$2"/"$(trim_empty_lines $3; cat $3)"}
    # Write the result back to the original file
    rm -f $1; touch $1; printf "$result" >> $1
}

create_scratch () {
    # Create temporary directory
    scratch=$(mktemp -d -t TemporaryDirectory)
    # Run cleanup on exit
    trap "rm -rf \"$scratch\"" EXIT
}

prune_firebase () {
    # Drop every product we do not ship. Firebase.zip keeps Firebase Core and its shared
    # dependencies in the FirebaseAnalytics folder, next to Analytics itself: keep the folder
    # under a neutral name and remove only the Analytics frameworks from it.
    for dir in */; do
        local name="${dir%/}"
        if [[ "$name" != "FirebaseAnalytics" && " ${products[*]} " != *" $name "* ]]; then rm -rf "$name"; fi
    done
    for framework in "${analytics_frameworks[@]}"; do rm -rf "FirebaseAnalytics/$framework.xcframework"; done
    mv FirebaseAnalytics "$core_library"
}

verify_firebase () {
    # Refuse a zip that is not the requested version, or a framework Google did not sign.
    local found=$(plutil -extract CFBundleShortVersionString raw "$core_library/FirebaseCore.xcframework/ios-arm64/FirebaseCore.framework/Info.plist")
    if [[ "$found" != "$latest" ]]; then echo "Firebase.zip holds $found, expected $latest"; exit 1; fi
    for i in */*.xcframework; do
        codesign --verify --deep --strict "$i"
        local signature=$(codesign -dv "$i" 2>&1)
        if [[ "$signature" != *"TeamIdentifier=$google_team_id"* ]]; then echo "$i is not signed by Google"; exit 1; fi
    done
}

rename_frameworks () {
    local prefix="$1"
    for i in */*.xcframework; do (
        local name=$(xcframework_name $i)
        cd "$i/../"; mv "$name.xcframework" "$prefix$name.xcframework"
    ) & done;
    wait
}

zip_frameworks () {
    for i in */*.xcframework; do (
        local name=$(xcframework_name $i)
        # Preserve symlinks using the -y option
        cd "$i/../"; zip -ryqo "$name.xcframework.zip" "$name.xcframework"
    ) & done;
    wait
}

prepare_files_for_distribution () {
    local dist="$1"
    # Create the distribution folder
    mkdir $dist
    # Copy unzipped frameworks for testing (Package.swift using local binaries)
    # The same framework sits in several product folders: copy it once, keeping symlinks,
    # so that its signature stays valid
    for i in */*.xcframework; do
        if [ ! -e "$dist/$(basename "$i")" ]; then cp -R "$i" "$dist"; fi
    done
    # Copy zipped frameworks for release (these will be uploaded to remote)
    for i in */*.xcframework.zip; do cp -f $i $dist; done
}

generate_sources () {
    local sources="$1"
    # Create the sources folder
    mkdir $sources
    # Create the sources for the umbrella header and modulemap
    mkdir "$sources/Firebase"
    cp -f "Firebase.h" "$sources/Firebase"
    cp -f "module.modulemap" "$sources/Firebase"
    touch "$sources/Firebase/dummy.m" # SPM requires at least one source file
    # Create a source folder for each library target
    for i in */; do
        local name="$(library_name $i)";
        mkdir "$sources/${name}"
        touch "$sources/$name/dummy.swift" # SPM requires at least one source file
        # Copy resources for the target to the source folder
        if [ -d "$i/Resources" ]; then
            cp -rf "$i/Resources" "$sources/$name"
        fi
        # Copy any non-resource/non-xcframework files
        for f in ${i}*; do if [[ $(excludes $f) ]]; then
            # Copy file(s) to sources
            if [[ -d $f ]]; then
                cp -rf $f "$sources/$name"
            else
                cp -f $f "$sources/$name"
            fi
        fi; done;
    done;
}

write_library () {
    local library=$(library_name $1)
    local output="$2"
    local comma="$3"

    # Write to file
    touch $output
    printf "$comma
    .library(
      name: \"$library\",
      targets: [\"${library}Target\"]
    )" >> $output
}

conditional_dependency () {
    local name=$(xcframework_name "$1")
    local output="$2"
    # Check xcframework folder for platform specific architectures
    local ios=$(ls "$name.xcframework" | grep "ios-" >/dev/null && echo ".iOS")
    local tvos=$(ls "$name.xcframework" | grep "tvos-" >/dev/null && echo ".tvOS")
    local macos=$(ls "$name.xcframework" | grep "macos-" >/dev/null && echo ".macOS")
    # Get array of platforms
    local platforms=($ios $tvos $macos)
    # Join platforms with comma and space separation
    local joined=$( echo ${platforms[*]} | sed 's/ /, /g' )
    if [ "$joined" == ".iOS, .tvOS, .macOS" ]; then
        # Supports all platforms, conditional not needed
        echo "\"$name\""
    else
        # Create conditional dependency from target and platforms
        echo ".target(name: \"$name\", condition: .when(platforms: [$joined]))"
    fi
}

write_target () {
    local library=$(library_name $1)
    local output=$2
    local comma=$3
    local target="${library}Target"
    local dependencies=$(ls -1A $library | grep .xcframework.zip)
    local excludes=$(excludes "$(ls -1A $library)")
    # Write to file
    touch $output
    printf "$comma
    .target(
      name: \"$target\",
      dependencies: [
        \"Firebase\"" >> $output
    # All targets depend on the core binaries
    if [ $library != "$core_library" ]; then printf ",
        \"${core_library}Target\"" >> $output
    fi
    # Library specific dependencies are expected to be inside the $library folder
    echo "$dependencies" | while read -r dependency; do printf ",
        $(cd $library; conditional_dependency $dependency)" >> $output
    done; printf "\n      ]" >> $output;
    # Path
    printf ",\n      path: \"Sources/$library\"" >> $output
    # Non-resource, non-xcframework files
    if [[ $excludes ]]; then
        printf ",\n      exclude: [" >> $output
        comma=""; echo "$excludes" | while read -r exclude; do printf "$comma
        \"$exclude\"" >> $output; comma=",";
        done; printf "\n      ]" >> $output;
    fi
    
    # Resources are expected to be inside the $library/Resources folder
    # Note: disabling because these resources will not be in the main bundle
    # https://github.com/akaffenberger/firebase-ios-sdk-xcframeworks/issues/23
    # if [ -d "$library/Resources" ]; then
    #    printf ",\n      resources: [" >> $output
    #    comma=""; for i in "$library/Resources/*"; do printf "$comma
    #    .process(\"Resources/$(resource_name $i)\")" >> $output; comma=","
    #    done; printf "\n      ]" >> $output;
    # fi
    
    # Closing bracket
    printf "\n    )" >> $output
}

write_binary () {
    local file=$1
    local repo=$2
    local version=$3
    local output=$4
    local comma=$5

    # Get the checksum
    touch Package.swift # checksum command requires a package file
    local checksum=$(swift package compute-checksum "$file")
    local name=$(xcframework_name $file)
    local library=$(library_name $file)

    # Write to file
    touch $output
    printf "$comma
    .binaryTarget(
      name: \"$name\",
      url: \"$repo/releases/download/$version/$name.xcframework.zip\",
      checksum: \"$checksum\"
    )" >> $output
}

write_local_binary () {
    local name=$(xcframework_name "$1")
    local dist=$2
    local output=$3
    local comma=$4

    # Write to file
    touch $output
    printf "$comma
    .binaryTarget(
      name: \"$name\",
      path: \"$dist/$name.xcframework\"
    )" >> $output
}

generate_swift_package () {
    local package="$1"
    local template="$2"
    local dist="$3"
    local repo="$4"
    local local_dist="$5"
    local libraries="libraries.txt"
    local targets="targets.txt"
    local binaries="binaries.txt"
    # Create package file
    cp -f $template $package
    # Create libraries
    comma=""; for i in */; do write_library $i $libraries $comma && comma=","; done
    # Create targets that define each library's dependencies and resources
    comma=""; for i in */; do write_target $i $targets $comma && comma=","; done
    # Create binary targets
    if [[ -n $local_dist ]]; then
        echo "Creating local Package.swift for testing..."
        # Create locally pathed binary targets, useful for testing/validating
        comma=""; for i in $dist/*.xcframework; do write_local_binary $i $local_dist $binaries $comma && comma=","; done
    else
        echo "Creating release Package.swift..."
        # Create remote binary targets, these will be hosted on a github release
        comma=""; for i in $dist/*.xcframework.zip; do write_binary $i $repo $latest $binaries $comma && comma=","; done
    fi
    # Replace the templates with the generated values
    template_replace $package "// GENERATE LIBRARIES" $libraries; rm -f $libraries
    template_replace $package "// GENERATE TARGETS" $targets; rm -f $targets
    template_replace $package "// GENERATE BINARIES" $binaries; rm -f $binaries
}

find_and_extract_firebase_zip() {
    echo "Looking for downloaded Firebase zip..."
    
    # Find the zip file and ensure it's called Firebase.zip
    zip_file=$(find . -name "*.zip" | head -n 1)
    
    if [ -n "$zip_file" ]; then
        echo "Found downloaded zip file: $zip_file"
        mv "$zip_file" "Firebase.zip"
        unzip -q Firebase.zip
    else
        echo "No downloaded zip file found in root directory. Exiting."
        exit 1
    fi
    
    # If there's no Firebase folder at the root, look for a relevant zip file and unzip it
    if [ ! -d "Firebase" ]; then
        echo "Firebase directory not found in root. Looking for zip file in subdirectories..."
        # Look for Firebase zip files in subdirectories (excluding carthage)
        for dir in */; do
            if [ -d "$dir" ] && [ "$dir" != "carthage/" ]; then
                firebase_zip=$(find "$dir" -name "Firebase*.zip" | head -n 1)
                if [ -n "$firebase_zip" ]; then
                    echo "Found Firebase zip in $dir: $firebase_zip"
                    unzip -q "$firebase_zip"
                    break
                fi
            fi
        done
        # Did we find the right Firebase directory?
        if [ ! -d "Firebase" ]; then
            echo "Firebase directory not found in any subdirectory. Exiting."
            exit 1
        fi
    fi
    
    echo "Firebase zip found and extracted successfully"
}

# Exit when any command fails
set -e
set -o pipefail

# Usage: package.sh <firebase-version> [--skip-release]
latest="${1:?Usage: package.sh <firebase-version> [--skip-release]}"
skip_release=""
if [[ "${2:-}" == "--skip-release" ]]; then skip_release=1; fi

# Repos
firebase_repo="https://github.com/firebase/firebase-ios-sdk"
xcframeworks_repo="https://github.com/smash-fit/firebase-ios-sdk-xcframeworks"

# The products the noa apps use. Everything else in Firebase.zip is left out.
products=(FirebaseAppCheck FirebaseAuth FirebaseFirestore FirebaseFunctions FirebaseRemoteConfig FirebaseStorage)
analytics_frameworks=(FirebaseAnalytics GoogleAdsOnDeviceConversion GoogleAppMeasurement GoogleAppMeasurementIdentitySupport)
core_library="FirebaseCoreBase"
google_team_id="EQHXZ8M8AV"

if git ls-remote --exit-code --tags origin "$latest" > /dev/null; then echo "$latest is already published"; exit 1; fi

distribution="dist"
sources="Sources"
package="Package.swift"

# Generate files in a temporary directory
# Use subshell to return to original directory when finished with scratchwork
create_scratch
(
    cd $scratch
    home=$OLDPWD
    echo "Downloading Firebase $latest..."
    gh release download "$latest" --pattern 'Firebase.zip' --repo $firebase_repo

    find_and_extract_firebase_zip
    cd Firebase
    echo "Keeping only the products we ship..."
    prune_firebase
    echo "Verifying version and signatures..."
    verify_firebase
    echo "Preparing xcframeworks for distribution..."
    rename_frameworks "_"
    zip_frameworks
    echo "Creating distribution files..."
    prepare_files_for_distribution "../$distribution"
    echo "Creating source files..."
    generate_sources "../$sources"
    # Create test package using local binaries and make sure it builds
    generate_swift_package "../$package" "$home/package_template.swift" "../$distribution" $xcframeworks_repo $distribution
    echo "Validating..."
    (cd ..; swift package dump-package > /dev/null)
    (cd ..; swift build)
    # Create release package using remote binaries and make sure the Package.swift file is parseable
    generate_swift_package "../$package" "$home/package_template.swift" "../$distribution" $xcframeworks_repo ''
    echo "Validating..."
    (cd ..; swift package dump-package > /dev/null)
)

echo "Moving files to repo..."; cd ..
rm -rf "$sources" "$package"
mv "$scratch/$sources" "$sources"
mv "$scratch/$package" "$package"

if [[ $skip_release ]]; then echo "Done."; exit 0; fi

echo "Publishing $latest..."
git add -A "$sources" "$package"
git commit -m "Firebase $latest"
git tag "$latest"
git push --atomic origin HEAD "$latest"
gh release create "$latest" --title "Firebase $latest" --notes "Firebase Apple $latest from the official Firebase.zip, pruned to the products listed in .scripts/package.sh." "$scratch/$distribution"/*.xcframework.zip

echo "Done."
