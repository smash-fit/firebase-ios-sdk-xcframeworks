# firebase-ios-sdk-xcframeworks

Prebuilt Firebase Apple SDK binaries for Swift Package Manager, used by the noa iOS apps.
Forked from [akaffenberger/firebase-ios-sdk-xcframeworks](https://github.com/akaffenberger/firebase-ios-sdk-xcframeworks).

## What differs from upstream

- **Only the products we use:** FirebaseAppCheck, FirebaseAuth, FirebaseFirestore, FirebaseFunctions, FirebaseRemoteConfig and FirebaseStorage. Edit `products` in `.scripts/package.sh` to change the list.
- **No Firebase Analytics:** upstream makes every product depend on Analytics, because `Firebase.zip` keeps Firebase Core in its Analytics folder. Here those core frameworks are a separate `FirebaseCoreBase` target. `FirebaseABTesting` stays because Remote Config links against it.
- **Exact versions:** a release is built from the `Firebase.zip` of the version you ask for, and fails if the zip holds a different version or a framework Google did not sign. The kept frameworks are not modified, so Google's signatures stay valid.
- **No scheduled releases:** a release only happens when someone runs the workflow.

## Publishing a version

Run the **Publish Release** workflow and enter the Firebase version, or from the command line:

```bash
gh workflow run package.yml -R smash-fit/firebase-ios-sdk-xcframeworks -f version=12.19.3
```

The workflow commits the generated `Package.swift` and `Sources`, tags the version and uploads the zipped xcframeworks to a GitHub release. This repository has to stay public: Swift Package Manager and Xcode Cloud download those zips without authentication.
