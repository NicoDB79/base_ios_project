//
//  ProductString+Extension.swift
//  BaseProject
//
//  Created by Nicola De Bei on 26/01/24.
//

import Foundation

extension String {
    mutating func replaceWithProduct() -> String {
        let kPlaceholdersKey : String = "PLACEHOLDERS"
        let kPlaceholders: [String] = ["_P_"]
        
        guard let companyDict = Bundle.main.infoDictionary?[kPlaceholdersKey] as? [String:AnyObject] else { return self }
        let placeholders = kPlaceholders.filter { self.contains($0) }
        placeholders.forEach {
            if let value = companyDict[$0] as? String {
                self = replacingOccurrences(of: "\($0)", with: value)
            }
        }
        return self
    }
}
