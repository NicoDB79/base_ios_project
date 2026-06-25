//
//  AppScheme.swift
//  ProjectDescriptionHelpers
//
//  Created by Nicola De Bei on 08/05/24.
//

import Foundation
import ProjectDescription

public enum AppScheme {
    case target1Staging, target1Production,
         target2Staging, target2Production
    
    var target: AppTarget {
        switch self {
        case .target1Staging, .target1Production:
            AppTarget.target1
            
        case .target2Staging, .target2Production:
            AppTarget.target2
        }
    }
    
    var environment: AppEnvironment {
        switch self {
        case .target1Staging, .target2Staging:
            AppEnvironment.staging
            
        case .target1Production, .target2Production:
            AppEnvironment.production
        }
    }
    
    var debugEnvironmentConfig: AppEnvironmentConfig {
        switch self {
        case .target1Staging, .target2Staging:
            AppEnvironmentConfig.stagingDebug
            
        case .target1Production, .target2Production:
            AppEnvironmentConfig.productionDebug
        }
    }
    
    var releaseEnvironmentConfig: AppEnvironmentConfig {
        switch self {
        case .target1Staging, .target2Staging:
            AppEnvironmentConfig.stagingRelease
            
        case .target1Production, .target2Production:
            AppEnvironmentConfig.productionRelease
        }
    }
    
    public var scheme: ProjectDescription.Scheme {
        let targetName = target.targetName

        var testAction: TestAction?
        if target == .target1 {
            testAction = .targets(
                ["Target1Tests"],
                configuration: debugEnvironmentConfig.name
            )
        }

        return ProjectDescription.Scheme.scheme(
            name: "\(targetName)-\(environment.name)",
            shared: true,
            buildAction: .buildAction(targets: [.target(targetName)]),
            testAction: testAction,
            runAction: .runAction(
                configuration: debugEnvironmentConfig.name,
                executable: .executable(.target(targetName))
            ),
            archiveAction: .archiveAction(configuration: releaseEnvironmentConfig.name),
            profileAction: .profileAction(
                configuration: releaseEnvironmentConfig.name,
                executable: .executable(.target(targetName))
            ),
            analyzeAction: .analyzeAction(configuration: releaseEnvironmentConfig.name)
        )
    }
}

