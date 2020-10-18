# TrefleSwiftSDK

![Swift](https://img.shields.io/badge/Swift-5.1-orange.svg)
![Platforms](https://img.shields.io/badge/Platforms-iOS-brightgreen.svg?style=flat)
[![SwiftPM](https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg?style=flat)](https://cocoapods.org)
[![Twitter](https://img.shields.io/badge/Twitter-@baza207-blue.svg?style=flat)](https://twitter.com/baza207)

TrefleSwiftSDK is a Swift wrapper around the [Trefle API](https://trefle.io).

This is currently a work in progress. There is a list of currently supported features listed below.

- [x] Authentication  
- [x] Kingdoms  
- [x] Subkingdoms  
- [x] Divisions  
- [x] Families  
- [x] Genus  
- [x] Plants  
- [x] Species  
- [x] Distribution Zones  
- [x] Operation support
- [x] Combine support
- [ ] Full error handling
- [x] Basic test suite
- [ ] Deep test suite

**Note:** The current version of  `TrefleSwiftSDK` is based on [Trefle 1.6.0](https://docs.trefle.io/reference).

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Create a Trefle account at: [https://trefle.io](https://trefle.io/users/sign_up)
- Once you've created your account and confirmed it via the confirmation email, you will be able to access your "Access Token" at [https://trefle.io/profile](https://trefle.io/profile)

## Installation

### Swift Package Manager

To integrate `TrefleSwiftSDK` into your Xcode project using [Swift Package Manager](https://swift.org/package-manager), add `TrefleSwiftSDK` as a dependency to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/Baza207/TrefleSwiftSDK.git", .upToNextMajor(from: "0.1.0"))
]
```

### Carthage

To integrate `TrefleSwiftSDK` into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your `Cartfile` with the following:

```ogdl
github "Baza207/TrefleSwiftSDK" "0.1.0"
```

### CocoaPods

To integrate `TrefleSwiftSDK` into your Xcode project using [CocoaPods](https://cocoapods.org), specify it in your `Podfile` with the following:

```ruby
pod 'TrefleSwiftSDK', '~> 0.1.0'
```

## Usage

### Basic Setup

Once you have a access token from your [Trefle Profile](https://trefle.io/profile) you will also need to create an URI in your Xcode project. To do this you can follow the steps to [Register Your URL Scheme](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content/defining_a_custom_url_scheme_for_your_app) in the Apple documentation.

Once you have this, you can import the `TrefleSwiftSDK` framework in your project and set it up for use.

1. Import `TrefleSwiftSDK` in your `AppDelegate`:

```swift
import TrefleSwiftSDK
```

2. Setup `TrefleSwiftSDK` by calling `configure(accessToken:uri:)` in `application(_:didFinishLaunchingWithOptions:)`, passing in your access token from your [Trefle Profile](https://trefle.io/profile) as well as the URI you setup in Xcode Info tab.

```swift
Trefle.configure(accessToken: "<Access Token>", uri: "<Redirect URI>")
```

3. You can then use all the fetch and search calls from any of the managers in the project. All the authentication is handled by the framework using the given access token, meaning you don't have to worry about logging in users or logging them out. All the JWT autnetication and re-authentication on expired tokens is done automatically.

## Contributors

[James Barrow](https://github.com/baza207)

## License

[MIT Licence](LICENSE)
