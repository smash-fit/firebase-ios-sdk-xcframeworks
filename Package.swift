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
        "_GeminiAPIClient",
        "_GeminiAPIDataModels",
        "_GeminiLanguageModel",
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
        "_absl",
        "_FirebaseAppCheckInterop",
        "_FirebaseCoreExtension",
        "_FirebaseFirestore",
        "_FirebaseFirestoreInternal",
        "_FirebaseSharedSwift",
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
      name: "_absl",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_absl.xcframework.zip",
      checksum: "75f111bbbe0da62ff21f4f4d03646648d4bd505b7386d85104150297d94b981a"
    ),
    .binaryTarget(
      name: "_AppCheckCore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_AppCheckCore.xcframework.zip",
      checksum: "e1fd1efddca53057c15982dee1571695d65f09316e0b109753a129a63d0fdb5b"
    ),
    .binaryTarget(
      name: "_FBLPromises",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FBLPromises.xcframework.zip",
      checksum: "2f72ef0fb531d05e9c2be70f6dcbaec79930304015606a72acf4050afca0b691"
    ),
    .binaryTarget(
      name: "_FirebaseABTesting",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseABTesting.xcframework.zip",
      checksum: "95020ae40d87688a45c8c449170f1dc304c30c04ce8853c6ff68562014826023"
    ),
    .binaryTarget(
      name: "_FirebaseAILogic",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAILogic.xcframework.zip",
      checksum: "e8dfd5ff8d9df26d1da300a8d38c86b7a5bd46765cfa3b4095fa7383a5818a0d"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheck",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAppCheck.xcframework.zip",
      checksum: "cc1c41deb74226146175da4addd639e934a97758d19215cf3c1048fbac8d6ac3"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheckInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAppCheckInterop.xcframework.zip",
      checksum: "74056fe7239f34603dd4bc38f6ff37c3e08f4e721986f132af1d9db9ad010fe0"
    ),
    .binaryTarget(
      name: "_FirebaseAuth",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAuth.xcframework.zip",
      checksum: "5ec3361e20f43ceedd1462477634a8434c39d2de01e804509968431b9fa86b02"
    ),
    .binaryTarget(
      name: "_FirebaseAuthInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseAuthInterop.xcframework.zip",
      checksum: "bbd337f4bc1906b3d5e7e76ff89db83925bd8ff2d08a0c9a27094bfcb97424f0"
    ),
    .binaryTarget(
      name: "_FirebaseCore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCore.xcframework.zip",
      checksum: "460379023f6be1f294ab6e5f39096c132bca84413b6dbeae200f65471a0d1827"
    ),
    .binaryTarget(
      name: "_FirebaseCoreExtension",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCoreExtension.xcframework.zip",
      checksum: "8b794dfdff296497f148f980157ccce1611f9189222f533bb2f791017e273b01"
    ),
    .binaryTarget(
      name: "_FirebaseCoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseCoreInternal.xcframework.zip",
      checksum: "871f574572b221e57d01f8f8bfccabfc745c3a71ea8191eb3244ec520ad96d48"
    ),
    .binaryTarget(
      name: "_FirebaseFirestore",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFirestore.xcframework.zip",
      checksum: "ffec9f1c03ffbb0df40a2b6a53d26fb57bd0d4d543e7aa17b30eb07a957bfdb6"
    ),
    .binaryTarget(
      name: "_FirebaseFirestoreInternal",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFirestoreInternal.xcframework.zip",
      checksum: "2a774e91b5abf02b6703a0c0f3fa79e75f762781c19df9030a178cad0eb1ae6e"
    ),
    .binaryTarget(
      name: "_FirebaseFunctions",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseFunctions.xcframework.zip",
      checksum: "80b2cd09f0e0693cabef93d5ed73d984db45c0bd14bac853e69ed17ee1f02c85"
    ),
    .binaryTarget(
      name: "_FirebaseInstallations",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseInstallations.xcframework.zip",
      checksum: "c65bfa045c2fc2f91f894088ccc3073a5af24e15f7d4f6b9c5c47423c5c6307c"
    ),
    .binaryTarget(
      name: "_FirebaseMessagingInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseMessagingInterop.xcframework.zip",
      checksum: "a78b6ea1e7e67d365488dc5388ce47ee89cb764a68926913664bfe323de85cfd"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfig",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseRemoteConfig.xcframework.zip",
      checksum: "037b61dfd62aa89b51d8910ff9d5d87ce3f8296ae8fa56f3b28fd31e86d09527"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfigInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseRemoteConfigInterop.xcframework.zip",
      checksum: "5f66af6130a59997f60036fb63e85bdfd348914c88b3472694acf73c9df85b09"
    ),
    .binaryTarget(
      name: "_FirebaseSharedSwift",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseSharedSwift.xcframework.zip",
      checksum: "14204883705f695ba2b31497fef0a6bb74d6583bd4dfd2e1eeb62ee748bcc4b9"
    ),
    .binaryTarget(
      name: "_FirebaseStorage",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_FirebaseStorage.xcframework.zip",
      checksum: "da14ecf123912d6a948fa53ba51bf928665cd2d77a7495644bf03b3a2122bdc3"
    ),
    .binaryTarget(
      name: "_GeminiAPIClient",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GeminiAPIClient.xcframework.zip",
      checksum: "8174c44ac2385afb31575bbd59139d01ff05bf6acb44ee5a7c86b80a3071aae3"
    ),
    .binaryTarget(
      name: "_GeminiAPIDataModels",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GeminiAPIDataModels.xcframework.zip",
      checksum: "3253eaba55328456cf468d386fe832adb034626d181ca5afc745dad1a4d505fd"
    ),
    .binaryTarget(
      name: "_GeminiLanguageModel",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GeminiLanguageModel.xcframework.zip",
      checksum: "8b2c26cb8d3bcaea927f63cb3be2b8f0a311979f10572edb6a8329132ac0325a"
    ),
    .binaryTarget(
      name: "_GoogleUtilities",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GoogleUtilities.xcframework.zip",
      checksum: "b060ce913030fa74cafee6add418a58d7c92273494dd8579bcd9d548606be0d4"
    ),
    .binaryTarget(
      name: "_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_grpc.xcframework.zip",
      checksum: "a5ce98ca784844ed07b993f8b37d39eaab14fc3de71349e21ae2b117f0bfd298"
    ),
    .binaryTarget(
      name: "_grpcpp",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_grpcpp.xcframework.zip",
      checksum: "3796cabd3f0fbe35ae0efb3f6c930d1b46a5fda1161d95cf85a36c08e8a4f11d"
    ),
    .binaryTarget(
      name: "_GTMSessionFetcher",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_GTMSessionFetcher.xcframework.zip",
      checksum: "0133ba645188b8560011c233d6b33fa6e5c2d25490b51bdcb1bf5e9bbdf90ed2"
    ),
    .binaryTarget(
      name: "_leveldb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_leveldb.xcframework.zip",
      checksum: "142979aa77ee6b258f81f5ccfbd4532252e7af8cd4264501477d86ab1703fbef"
    ),
    .binaryTarget(
      name: "_nanopb",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_nanopb.xcframework.zip",
      checksum: "27f6a65712a96c5a9b5bf978daf832fe8012364e687f8bb77cb9b727dcaf6eed"
    ),
    .binaryTarget(
      name: "_openssl_grpc",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_openssl_grpc.xcframework.zip",
      checksum: "db85a412a4291064bec6d9e86f1eb4265605eb1e0a2c5d16876d6bfc4e53fa70"
    ),
    .binaryTarget(
      name: "_RecaptchaInterop",
      url: "https://github.com/smash-fit/firebase-ios-sdk-xcframeworks/releases/download/13.1.1/_RecaptchaInterop.xcframework.zip",
      checksum: "c57200bb1c043668215ba18ed0732f07e38000c28370f440b572c8076f1019b8"
    )
  ]
)
    