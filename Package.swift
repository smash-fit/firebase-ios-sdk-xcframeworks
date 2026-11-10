// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Firebase",
  platforms: [.iOS(.v11), .macOS(.v10_12), .tvOS(.v12), .watchOS(.v7)],
  products: [
    .library(
      name: "FirebaseAILogic",
      targets: ["FirebaseAILogicTarget"]
    ),
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
      name: "FirebaseAILogicTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_AppCheckCore",
        "_FirebaseAILogic",
        "_FirebaseAppCheck",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        .target(name: "_RecaptchaInterop", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAILogic"
    ),
    .target(
      name: "FirebaseAppCheckTarget",
      dependencies: [
        "Firebase",
        "FirebaseCoreBaseTarget",
        "_AppCheckCore",
        "_FirebaseAppCheck",
        "_FirebaseAppCheckInterop",
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
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_AppCheckCore.xcframework.zip",
      checksum: "4f231428762ae247efadbaa37b38b6a8c025cc4d3d8dae49bab83e87f91eaf3f"
    ),
    .binaryTarget(
      name: "_FBLPromises",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FBLPromises.xcframework.zip",
      checksum: "6f8453ca74229838a2a2dfcf1427787ed69bffad90778b136380d0ffe4e60b42"
    ),
    .binaryTarget(
      name: "_FirebaseABTesting",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseABTesting.xcframework.zip",
      checksum: "bbea61405b0a5ea0042d2d1ba0eaebe172590f9de0836fe85a4e88d671c4de71"
    ),
    .binaryTarget(
      name: "_FirebaseAILogic",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAILogic.xcframework.zip",
      checksum: "b295238fbb36f69b0caa3705383965ac6282b3c3b67f5f9d5d5f93e73fe90c22"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheck",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAppCheck.xcframework.zip",
      checksum: "65e890fcede89a1e6b49fade366f2c24705cbe39698c60c72b3d2544d55c8ce8"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheckInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAppCheckInterop.xcframework.zip",
      checksum: "4cbe05c8d9aa435876f96a000aece28cf36465022771cea8b030de1d038bbbd4"
    ),
    .binaryTarget(
      name: "_FirebaseAuth",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAuth.xcframework.zip",
      checksum: "dd8058205e2f48c6ac0ae436337f744eb28234ad53443ba9e4b62d426e50e2cd"
    ),
    .binaryTarget(
      name: "_FirebaseAuthInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAuthInterop.xcframework.zip",
      checksum: "39405799c3c673cd1344458c755a53071525e113d78188510d9eb07fc090557d"
    ),
    .binaryTarget(
      name: "_FirebaseCore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCore.xcframework.zip",
      checksum: "08a12ff877ba65f2713245399069f61f8fb905f866417ef5d05368a13bd17cad"
    ),
    .binaryTarget(
      name: "_FirebaseCoreExtension",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCoreExtension.xcframework.zip",
      checksum: "4c879bcb83b8ce774f0290bab601c6e28b71bbace24da89ff7de63d78981adce"
    ),
    .binaryTarget(
      name: "_FirebaseCoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCoreInternal.xcframework.zip",
      checksum: "fe885375331ccc6a8947ac3f90bfe45caef3a0fa45437cdd8aee9801f8265069"
    ),
    .binaryTarget(
      name: "_FirebaseFirestore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFirestore.xcframework.zip",
      checksum: "98508e7cdb51f096fd22a5f7b5f9573fe3bfb12b936a586aa4274f440744641a"
    ),
    .binaryTarget(
      name: "_FirebaseFirestoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFirestoreInternal.xcframework.zip",
      checksum: "28d3e4fe952c7733d5ae8d62e2cf84b44200c78680be8086ea9c82a22c4c7ac5"
    ),
    .binaryTarget(
      name: "_FirebaseFunctions",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFunctions.xcframework.zip",
      checksum: "401ca861b18b4d5134a25e8eb8716feef891d2cad1fa1dadb98293c5c73d50f2"
    ),
    .binaryTarget(
      name: "_FirebaseInstallations",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseInstallations.xcframework.zip",
      checksum: "ebe75bb9991eb24d7a5feeb99a06c9756b6b3ce883f4a756c1b3019e53ce3a74"
    ),
    .binaryTarget(
      name: "_FirebaseMessagingInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseMessagingInterop.xcframework.zip",
      checksum: "a0aac64099b6cdbbf5713bd2aceb170934bcd506e9b6dd066fbb657e5b4c8557"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfig",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseRemoteConfig.xcframework.zip",
      checksum: "d18dc4003bfa4061696a9fab7d89339e44aba262c3dbe7ecb155d87a5f596797"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfigInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseRemoteConfigInterop.xcframework.zip",
      checksum: "7983834b4bd250ffb331032222bd729d855cb1d0b26cadee51ae377da877a15b"
    ),
    .binaryTarget(
      name: "_FirebaseSharedSwift",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseSharedSwift.xcframework.zip",
      checksum: "a437d5ead5b7214ea3d2b9c6086139a617fc04ffcfa129918ce98d18386f39fe"
    ),
    .binaryTarget(
      name: "_FirebaseStorage",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseStorage.xcframework.zip",
      checksum: "8922d4eb59c224841d95131a8546718e7b0d10edbb5317a3b9237d35a881eded"
    ),
    .binaryTarget(
      name: "_GTMSessionFetcher",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GTMSessionFetcher.xcframework.zip",
      checksum: "b9ae9fcf90466e26b23226ed7748defa22d4d55bc525d3cb116cceb851220562"
    ),
    .binaryTarget(
      name: "_GoogleUtilities",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GoogleUtilities.xcframework.zip",
      checksum: "b7133c874707d193e590d702d50e421f682f03a688f58f2c8e0624d71f5b09c1"
    ),
    .binaryTarget(
      name: "_RecaptchaInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_RecaptchaInterop.xcframework.zip",
      checksum: "2df989bf6a119d05051b95c4e8b4a816542931f199bdb135c30fd5c9b5ffd7f0"
    ),
    .binaryTarget(
      name: "_absl",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_absl.xcframework.zip",
      checksum: "6b9ba61746523f822d3878e596a94eaca2a90a10a0ad61c955cdaf27d359fb69"
    ),
    .binaryTarget(
      name: "_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_grpc.xcframework.zip",
      checksum: "58b9a7b2481f86a59afdd90babea9af2e324f48fda927d878853da7329793da1"
    ),
    .binaryTarget(
      name: "_grpcpp",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_grpcpp.xcframework.zip",
      checksum: "62717cf55bb7a2c7fe66f033a795fad4bed714e17b0df3235c922e2e142baf8f"
    ),
    .binaryTarget(
      name: "_leveldb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_leveldb.xcframework.zip",
      checksum: "80ab59dbd3c742f33fbbcb827bf5a652cdd06eba6902876779ce2927e4184f9c"
    ),
    .binaryTarget(
      name: "_nanopb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_nanopb.xcframework.zip",
      checksum: "1d4f124610eb8f0ab7586a81ad1c63567b564e1af95c71b75e803b7bed97c028"
    ),
    .binaryTarget(
      name: "_openssl_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_openssl_grpc.xcframework.zip",
      checksum: "a8c0bb72639029d7fd4b7d5888cd5bcda4fe0974de60d658baa6262199cd0f26"
    )
  ]
)
    