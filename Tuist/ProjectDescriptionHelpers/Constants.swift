//
//  Constants.swift
//  ProjectDescriptionHelpers
//
//  Created by Nicola De Bei on 08/05/24.
//

import Foundation
@preconcurrency import ProjectDescription

public struct Constants {
    public static let deploymentTarget = "16.0"
    
    public static let commonSettings: ProjectDescription.SettingsDictionary =
    ["CODE_SIGNING_REQUIRED": "YES",
     "CODE_SIGNING_ALLOWED" : "YES",
     "CODE_SIGN_STYLE": "Automatic",
     "SWIFT_VERSION": "6.0",
     "TARGETED_DEVICE_FAMILY": "1",
     "CURRENT_PROJECT_VERSION": "$(VERSION_CODE)",
    ]
    
    public static let target1PreviewsSettings = {
        var cs = Constants.commonSettings
        cs["DEVELOPMENT_TEAM"] = ""
        cs["MARKETING_VERSION"] = "1.0.0"
        cs["CURRENT_PROJECT_VERSION"] = "1"
        return cs
    }()

    public static let target1TestSettings = {
        var cs = Constants.commonSettings
        cs["DEVELOPMENT_TEAM"] = ""
        return cs
    }()
    
    public static let projectConfigurationSettings: Settings =
        .settings(
            base: Constants.commonSettings,
            configurations: [
                .debug(name: AppEnvironmentConfig.stagingDebug.name),
                .release(name: AppEnvironmentConfig.stagingRelease.name),
                .debug(name: AppEnvironmentConfig.productionDebug.name),
                .release(name: AppEnvironmentConfig.productionRelease.name)
            ]
        )
    
    static let entitlementDict: ProjectDescription.Entitlements =
        .dictionary(
            [
                "com.apple.developer.networking.HotspotConfiguration": true,
                "com.apple.developer.networking.wifi-info": true
            ]
        )
    
    static let preScripts: [ProjectDescription.TargetScript] = [
        .pre(
            path: "Scripts/swiftgen.sh",
            name: "SwiftGen",
            basedOnDependencyAnalysis: false
        )
    ]

    static let postScripts: [ProjectDescription.TargetScript] =
    [
        /*
        .post(path: "Scripts/crashlytics.sh",
              name: "Upload dsym to crashlytics",
              inputPaths: [
                "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
                "$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)"
              ]
             ),
        */
    ]
    
    public static let dependencies: [ProjectDescription.TargetDependency] = [
            .external(name: "FactoryKit"),
            .external(name: "Lottie"),
            .external(name: "Collections"),
            .external(name: "FirebaseCore"),
            .external(name: "FirebaseCrashlytics"),
            .external(name: "SVProgressHUD"),
            .external(name: "Domain"),
            .external(name: "Data")
        ]
    
    static let commonSources: ProjectDescription.SourceFileGlob = "Sources/**"
    
    static let generatedSources: ProjectDescription.SourceFileGlob = "Resources/Generated/**"
    
    public static let commonResources: ProjectDescription.ResourceFileElement = "Resources/**"
    
    static let commonPlistDict: [String : ProjectDescription.Plist.Value] = [
        "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)",
        "ITSAppUsesNonExemptEncryption": "NO",
        "UIStatusBarStyle": "UIStatusBarStyleLightContent",
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": "NO",
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]
                ]
            ]
        ],
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "NSBonjourServices": ["_SC609._tcp."],
        "NSBluetoothAlwaysUsageDescription": "The app requires the use of Bluetooth to find devices",
        "NSLocalNetworkUsageDescription": "The app requires the use of local network to find devices",
        "NSLocationAlwaysAndWhenInUseUsageDescription": "The app requires the use of location to find devices",
        "NSLocationWhenInUseUsageDescription": "The app requires the use of local network to find devices",
        "NSCameraUsageDescription": "The app requires the use of camera to identify the barcode",
        "UIBackgroundModes": ["bluetooth-central", "fetch", "processing"],
        "UIAppFonts" : ["Notosans-Bold.ttf", "Notosans-Medium.ttf", "Notosans-Regular.ttf", "NotoSans-CondensedMedium.ttf", "NotoSans-CondensedBold.ttf"],
        "server_url": "$(server_url)"
    ]
    
    static let privacyManifest: PrivacyManifest =
        .privacyManifest(
            tracking: false,
            trackingDomains: [],
            collectedDataTypes: [
                [
                    "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeProductInteraction",
                    "NSPrivacyCollectedDataTypeLinked": false,
                    "NSPrivacyCollectedDataTypeTracking": false,
                    "NSPrivacyCollectedDataTypePurposes": [
                        "NSPrivacyCollectedDataTypePurposeAnalytics",
                    ],
                ],
                [
                    "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeOtherDiagnosticData",
                    "NSPrivacyCollectedDataTypeLinked": false,
                    "NSPrivacyCollectedDataTypeTracking": false,
                    "NSPrivacyCollectedDataTypePurposes": [
                        "NSPrivacyCollectedDataTypePurposeAnalytics",
                    ],
                ],
                [
                    "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypePerformanceData",
                    "NSPrivacyCollectedDataTypeLinked": false,
                    "NSPrivacyCollectedDataTypeTracking": false,
                    "NSPrivacyCollectedDataTypePurposes": [
                        "NSPrivacyCollectedDataTypePurposeAnalytics",
                    ],
                ],
                [
                    "NSPrivacyCollectedDataType": "NSPrivacyCollectedDataTypeCrashData",
                    "NSPrivacyCollectedDataTypeLinked": false,
                    "NSPrivacyCollectedDataTypeTracking": false,
                    "NSPrivacyCollectedDataTypePurposes": [
                        "NSPrivacyCollectedDataTypePurposeAnalytics",
                    ],
                ],
            ],
            accessedApiTypes: [
                [
                    "NSPrivacyAccessedAPIType": "NSPrivacyAccessedAPICategoryUserDefaults",
                    "NSPrivacyAccessedAPITypeReasons": [
                        "CA92.1",
                    ],
                ],
            ]
        )
}
