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
}

public enum AppEnvironmentConfig: String, CaseIterable {
    case stagingDebug, stagingRelease, productionDebug, productionRelease

    public var name: ConfigurationName {
        ConfigurationName(stringLiteral: self.rawValue.firstUppercased)
    }

    var buildConfig: AppConfig {
        switch self {
        case .stagingDebug, .productionDebug: return .debug
        case .stagingRelease, .productionRelease: return .release
        }
    }
}

public struct AppTargetEnvironmentConfig {
    let target: AppTarget
    let config: AppEnvironmentConfig

    var path: ProjectDescription.Path {
        "ConfigurationFiles/\(target.targetName).\(config.rawValue.lowercased()).xcconfig"
    }

    public var configuration: Configuration {
        switch config.buildConfig {
        case .debug:
            return .debug(name: config.name, xcconfig: path)
        case .release:
            return .release(name: config.name, xcconfig: path)
        }
    }
}

extension StringProtocol {
    public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
