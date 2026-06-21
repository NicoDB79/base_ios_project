//
//  AppTarget.swift
//  ProjectDescriptionHelpers
//
//  Created by Nicola De Bei on 08/05/24.
//

import Foundation
@preconcurrency import ProjectDescription

public enum AppTarget: String {
    case target1, target2

    public var targetName: String {
        self.rawValue.firstUppercased
    }
    
    public var name: ProjectDescription.TargetReference {
        ProjectDescription.TargetReference(stringLiteral: self.rawValue.firstUppercased)
    }
    
    var bundleIdentifier: String {
        switch self {
        case .target1:
            "com.company.target1"
            
        case .target2:
            "com.company.target2"
        }
    }
    
    var plistDict: [String : ProjectDescription.Plist.Value] {
        switch self {
        case .target1:
            var dict = Constants.commonPlistDict
            dict["CFBundleDisplayName"] = "Target1"
            dict["PLACEHOLDERS"] = ["_P_": "Target1"]
            dict["trackId"] = 1407253847
            dict["BGTaskSchedulerPermittedIdentifiers"] = "com.company.target1.sync"
            return dict

        case .target2:
            var dict = Constants.commonPlistDict
            dict["CFBundleDisplayName"] = "Target2"
            dict["PLACEHOLDERS"] = ["_P_": "Target2"]
            dict["trackId"] = 6446246874
            dict["BGTaskSchedulerPermittedIdentifiers"] = "com.company.target2.sync"
            return dict
        }
    }
    
    var sources: SourceFileGlob {
        switch self {
        case .target1:
            "Target1/**"
            
        case .target2:
            "Target2/**"
        }
    }
    
    var resources: ResourceFileElement {
        switch self {
        case .target1:
            "Target1/Resources/**"
            
        case .target2:
            "Target2/Resources/**"
        }
    }
    
    var targetSettings: ProjectDescription.SettingsDictionary {
        switch self {
        case .target1:
            var cs = Constants.commonSettings
            cs["DEVELOPMENT_TEAM"] = ""
            cs["MARKETING_VERSION"] = "$(APP_IOS_TARGET1_VERSION_NAME)"
            return cs
            
        case .target2:
            var cs = Constants.commonSettings
            cs["DEVELOPMENT_TEAM"] = ""
            cs["MARKETING_VERSION"] = "$(APP_IOS_TARGET2_VERSION_NAME)"
            return cs
        }
    }
    
    var configurationSettings: Settings {
        .settings(
            base: targetSettings,
            configurations: AppEnvironmentConfig.allCases.map {
                AppTargetEnvironmentConfig(target: self, config: $0).configuration
            }
        )
    }
    
    private func makeTarget(target: AppTarget) -> ProjectDescription.Target {
        .target(
            name: target.name.targetName,
            destinations: .iOS,
            product: .app,
            bundleId: target.bundleIdentifier,
            deploymentTargets: .iOS(Constants.deploymentTarget),
            infoPlist: .extendingDefault(with: plistDict),
            sources: [Constants.commonSources,
                      Constants.generatedSources,
                      sources],
            resources: .resources(
                [Constants.commonResources, resources],
                privacyManifest: Constants.privacyManifest
            ),
            //entitlements: Constants.entitlementDict,
            scripts: Constants.postScripts,
            dependencies: Constants.dependencies,
            settings: configurationSettings
        )
    }
    
    public var projectTarget: ProjectDescription.Target {
        switch self {
        case .target1:
            makeTarget(target: .target1)
            
        case .target2:
            makeTarget(target: .target2)
        }
    }
}
