//
//  AppConfigurations.swift
//  Packages
//
//  Created by Nicola De Bei on 08/05/24.
//

import Foundation
import ProjectDescription

public enum AppEnvironment: String {
    case staging, production
    
    public var name: String {
        self.rawValue.firstUppercased
    }
}

public enum AppConfig: String {
    case debug, release
    
    public var name: SettingValue {
        SettingValue(stringLiteral: self.rawValue.firstUppercased)
    }
    
    
    public var settings: ProjectDescription.SettingsDictionary {
        switch self {
        case .debug:
            [:]
        case .release:
            [:]
        }
        
    }
     
}

public enum AppEnvironmentConfig: String {
    case stagingDebug, stagingRelease, productionDebug, productionRelease
    
    public var name: ConfigurationName {
        ConfigurationName(stringLiteral: self.rawValue.firstUppercased)
    }
}

public enum AppTargetEnvironmentConfig {
    case target1StagingDebug,
         target1StagingRelease,
         target1ProductionDebug,
         target1ProductionRelease,
    
         target2StagingDebug,
         target2StagingRelease,
         target2ProductionDebug,
         target2ProductionRelease
    
    var path: ProjectDescription.Path {
        switch self {
        case .target1StagingDebug:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target1.stagingdebug.xcconfig")
            
        case .target1StagingRelease:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target1.stagingrelease.xcconfig")
            
        case .target1ProductionDebug:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target1.productiondebug.xcconfig")
            
        case .target1ProductionRelease:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target1.productionrelease.xcconfig")
            
        case .target2StagingDebug:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target2.stagingdebug.xcconfig")
            
        case .target2StagingRelease:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target2.stagingrelease.xcconfig")
            
        case .target2ProductionDebug:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target2.productiondebug.xcconfig")
            
        case .target2ProductionRelease:
            ProjectDescription.Path(stringLiteral: "ConfigurationFiles/Target2.productionrelease.xcconfig")
            
        }
    }
    
    public var configuration: Configuration {
        switch self {
        case .target1StagingDebug:
                .debug(name: AppEnvironmentConfig.stagingDebug.name,
                       settings: AppConfig.debug.settings,
                       xcconfig: path
                )
            
        case .target1StagingRelease:
                .release(name: AppEnvironmentConfig.stagingRelease.name,
                         settings: AppConfig.release.settings,
                         xcconfig: path
                )
            
        case .target1ProductionDebug:
                .debug(name: AppEnvironmentConfig.productionDebug.name,
                       settings: AppConfig.debug.settings,
                       xcconfig: path
                )
            
        case .target1ProductionRelease:
                .release(name: AppEnvironmentConfig.productionRelease.name,
                         settings: AppConfig.release.settings,
                         xcconfig: path
                )
            
        case .target2StagingDebug:
                .debug(name: AppEnvironmentConfig.stagingDebug.name,
                       settings: AppConfig.debug.settings,
                       xcconfig: path
                )
            
        case .target2StagingRelease:
                .release(name: AppEnvironmentConfig.stagingRelease.name,
                         settings: AppConfig.release.settings,
                         xcconfig: path
                )
            
        case .target2ProductionDebug:
                .debug(name: AppEnvironmentConfig.productionDebug.name,
                       settings: AppConfig.debug.settings,
                       xcconfig: path
                )
            
        case .target2ProductionRelease:
                .release(name: AppEnvironmentConfig.productionRelease.name,
                         settings: AppConfig.release.settings,
                         xcconfig: path
                )
        }
    }
}

extension StringProtocol {
    public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
