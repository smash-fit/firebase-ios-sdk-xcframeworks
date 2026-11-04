// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Firebase",
  platforms: [.iOS(.v11), .macOS(.v10_12), .tvOS(.v12), .watchOS(.v7)],
  products: [
    .library(
      name: "FirebaseAppCheck",
      targets: ["FirebaseAppCheckTarget"]
    ),
    .library(
      name: "FirebaseAuth",
      targets: ["FirebaseAuthTarget"]
    ),
    .library(
      name: "FirebaseCoreBase",
      targets: ["FirebaseCoreBaseTarget"]
    ),
    .library(
      name: "FirebaseFirestore",
      targets: ["FirebaseFirestoreTarget"]
    ),
    .library(
      name: "FirebaseFunctions",
      targets: ["FirebaseFunctionsTarget"]
    ),
    .library(
      name: "FirebaseRemoteConfig",
      targets: ["FirebaseRemoteConfigTarget"]
    ),
    .library(
      name: "FirebaseStorage",
      targets: ["FirebaseStorageTarget"]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Firebase",
      publicHeadersPath: "./"
    ),
    .target(
      name: "FirebaseAppCheckTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_AppCheckCore",
        "_FirebaseAppCheck",
        "_FirebaseAppCheckInterop",
        "_Promises",
        .target(name: "_RecaptchaInterop", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAppCheck"
    ),
    .target(
      name: "FirebaseAuthTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuth",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_GTMSessionFetcher",
        .target(name: "_RecaptchaInterop", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAuth"
    ),
    .target(
      name: "FirebaseCoreBaseTarget",
      dependencies: [
        "Firebase",
        "_FBLPromises",
        "_FirebaseCore",
        "_FirebaseCoreInternal",
        "_FirebaseInstallations",
        "_GoogleUtilities",
        "_nanopb"
      ],
      path: "Sources/FirebaseCoreBase"
    ),
    .target(
      name: "FirebaseFirestoreTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseCoreExtension",
        "_FirebaseFirestore",
        "_FirebaseFirestoreInternal",
        "_FirebaseSharedSwift",
        "_absl",
        "_grpc",
        "_grpcpp",
        "_leveldb",
        "_openssl_grpc"
      ],
      path: "Sources/FirebaseFirestore"
    ),
    .target(
      name: "FirebaseFunctionsTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_FirebaseFunctions",
        "_FirebaseMessagingInterop",
        "_FirebaseSharedSwift",
        "_GTMSessionFetcher"
      ],
      path: "Sources/FirebaseFunctions"
    ),
    .target(
      name: "FirebaseRemoteConfigTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_FirebaseABTesting",
        "_FirebaseRemoteConfig",
        "_FirebaseRemoteConfigInterop",
        "_FirebaseSharedSwift"
      ],
      path: "Sources/FirebaseRemoteConfig"
    ),
    .target(
      name: "FirebaseStorageTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_FirebaseStorage",
        "_GTMSessionFetcher"
      ],
      path: "Sources/FirebaseStorage"
    ),
    .binaryTarget(
      name: "_AppCheckCore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_AppCheckCore.xcframework.zip",
      checksum: "004700d78312e1da044f6050ab9a39e34bad5511d8fe0505b659539888db592b"
    ),
    .binaryTarget(
      name: "_FBLPromises",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FBLPromises.xcframework.zip",
      checksum: "2c55be9d946d113b95e7492c4da02e117d36d5583b97585abe97dd2f6298c91d"
    ),
    .binaryTarget(
      name: "_FirebaseABTesting",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseABTesting.xcframework.zip",
      checksum: "1d9e4e288dc9654b4dc72135d0089fa23d525023cf587159804fa3b7b8316b08"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheck",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseAppCheck.xcframework.zip",
      checksum: "d4d2e671a6334643ab9b6c308e36e646092190d2feb8e1836f8f61fcde8ae1ff"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheckInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseAppCheckInterop.xcframework.zip",
      checksum: "5bec320e6af69f9eeef6b3b3e4e70709869f1bbd6cf558ceac42d18cd610dea1"
    ),
    .binaryTarget(
      name: "_FirebaseAuth",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseAuth.xcframework.zip",
      checksum: "b5e64cf9b483fb1a028e9fc46c07ac6e63089f8863d385f6e50ac1d0fd99e05c"
    ),
    .binaryTarget(
      name: "_FirebaseAuthInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseAuthInterop.xcframework.zip",
      checksum: "3c0cc88208d3458ac1050df5598ae79b798b8313afc37b57f1323a846759f426"
    ),
    .binaryTarget(
      name: "_FirebaseCore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseCore.xcframework.zip",
      checksum: "e91f2534b51c1653599f7b5fe3020db04db798f8ab8cbffb863be93c4fc54dc7"
    ),
    .binaryTarget(
      name: "_FirebaseCoreExtension",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseCoreExtension.xcframework.zip",
      checksum: "608e21e07d867dd0d2b2c7041c93abafa45276f2f2a352254276bceed3ba6abc"
    ),
    .binaryTarget(
      name: "_FirebaseCoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseCoreInternal.xcframework.zip",
      checksum: "d3c33b211662f20053e024b87b22fe676bff47cd992ec793a20b39b13255b17b"
    ),
    .binaryTarget(
      name: "_FirebaseFirestore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseFirestore.xcframework.zip",
      checksum: "50ab88da38ed0d603fd69d92315930ac5b928920e7612da5ae083b5da8f8d932"
    ),
    .binaryTarget(
      name: "_FirebaseFirestoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseFirestoreInternal.xcframework.zip",
      checksum: "d9bf229ac91a928e573d62bb602a4a9af2a2ce48042b42c3dd0d8ffe23e3b68b"
    ),
    .binaryTarget(
      name: "_FirebaseFunctions",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseFunctions.xcframework.zip",
      checksum: "068ea348c0233aa3613c6ab4366595be7a6713a13436eab6336f2631ef748442"
    ),
    .binaryTarget(
      name: "_FirebaseInstallations",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseInstallations.xcframework.zip",
      checksum: "6c06c602b96928a401dc282168cb7e075d2383d5cd529dea03e64f29b0e4bc1a"
    ),
    .binaryTarget(
      name: "_FirebaseMessagingInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseMessagingInterop.xcframework.zip",
      checksum: "65676dc47c606c11bd049460075d12c0ea524464e17bb78dcc76c0c16cd1197c"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfig",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseRemoteConfig.xcframework.zip",
      checksum: "5b43ba0cfa0f5ad6a31b221d1ad761688b95a848630091a37918958f9e27529f"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfigInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseRemoteConfigInterop.xcframework.zip",
      checksum: "34eb6a0d4bfb6d482e931c41fe365e31c9a9e764258238c3187ac538c39136b8"
    ),
    .binaryTarget(
      name: "_FirebaseSharedSwift",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseSharedSwift.xcframework.zip",
      checksum: "eabbffddbbdb36071dda673c629917761aa627f3a21874d2084ea83681a43efb"
    ),
    .binaryTarget(
      name: "_FirebaseStorage",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_FirebaseStorage.xcframework.zip",
      checksum: "a0f0f1de807898c575b81a66c5b2bcfad7e534406b3059ff5916c0fd39241b3f"
    ),
    .binaryTarget(
      name: "_GTMSessionFetcher",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_GTMSessionFetcher.xcframework.zip",
      checksum: "b8b0668b903c959c4b647ae30db9fdbba2226fc184287d9556bd27bfb31a027a"
    ),
    .binaryTarget(
      name: "_GoogleUtilities",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_GoogleUtilities.xcframework.zip",
      checksum: "a5d202d076afeaa0d06af586d6561e9505fb282dce94e73b3d3f1a5eba7bef0e"
    ),
    .binaryTarget(
      name: "_Promises",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_Promises.xcframework.zip",
      checksum: "a2aa44bcf183edb3cd61d200aed88f3cdbaf8675b5f947e257131bb58e6d0717"
    ),
    .binaryTarget(
      name: "_RecaptchaInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_RecaptchaInterop.xcframework.zip",
      checksum: "b6fd9115446fee20b8b92f1a34406c8f353ad8b4238636b0cf6140780ecc9e75"
    ),
    .binaryTarget(
      name: "_absl",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_absl.xcframework.zip",
      checksum: "441081075f17a6a3a262be5c897ba6248e46bf919ee68f7733db8b366a861cf1"
    ),
    .binaryTarget(
      name: "_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_grpc.xcframework.zip",
      checksum: "11f42f17da58ca2b730e846e671558644cc93ccd6de5bd5b9cac553043210c9a"
    ),
    .binaryTarget(
      name: "_grpcpp",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_grpcpp.xcframework.zip",
      checksum: "33bd09840091f8083353adc69659774b663216cbf1c9d6e27c61d879e85929e6"
    ),
    .binaryTarget(
      name: "_leveldb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_leveldb.xcframework.zip",
      checksum: "501a3c20b9029a041344a5704acf55a2ba05a04919817bda5c8cb0163879936a"
    ),
    .binaryTarget(
      name: "_nanopb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_nanopb.xcframework.zip",
      checksum: "5d9cd96eafb382d781fd9a929c9c588efcbdfc318ff60a4ff017322e6b9f3c48"
    ),
    .binaryTarget(
      name: "_openssl_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/12.19.3/_openssl_grpc.xcframework.zip",
      checksum: "5b077234a65b19fcfec45eb8ee2b88ffbf263310aae84fa302ab8157a51aaa04"
    )
  ]
)
    