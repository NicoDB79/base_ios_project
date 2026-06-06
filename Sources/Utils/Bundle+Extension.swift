//
//  Bundle+Extension.swift
//  BaseProject
//
//  Created by Nicola De Bei on 06/04/23.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var serverURLString: String? {
        infoDictionary?["server_url"] as? String
    }
}
