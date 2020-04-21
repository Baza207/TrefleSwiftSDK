// swift-tools-version:5.0
//
//  Package.swift
//  TrefleSwiftSDK
//
//  Created by James Barrow on 2020-04-21.
//  Copyright © 2020 Pig on a Hill Productions. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "TrefleSwiftSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "TrefleSwiftSDK",
            targets: ["TrefleSwiftSDK"])
    ],
    targets: [
        .target(
            name: "TrefleSwiftSDK",
            path: "Source")
    ],
    swiftLanguageVersions: [.v5]
)
