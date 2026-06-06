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
        makeScheme(scheme: self)
    }
    
    
    private func makeScheme(scheme: AppScheme) -> ProjectDescription.Scheme {
        let targetName = scheme.target.targetName  // ← stringa pura

        return ProjectDescription.Scheme.scheme(
            name: "\(targetName)-\(scheme.environment.name)",
            shared: true,
            buildAction: .buildAction(targets: [.target(targetName)]),  // ← esplicito
            runAction: .runAction(
                configuration: scheme.debugEnvironmentConfig.name,
                executable: .target(targetName)                          // ← .target() non .executable()
            ),
            archiveAction: .archiveAction(configuration: scheme.releaseEnvironmentConfig.name),
            profileAction: .profileAction(
                configuration: scheme.releaseEnvironmentConfig.name,
                executable: .target(targetName)                          // ← .target() non .executable()
            ),
            analyzeAction: .analyzeAction(configuration: scheme.releaseEnvironmentConfig.name)
        )
    }
}

