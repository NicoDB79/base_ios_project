//
//  Int+Extension.swift
//  BaseProject
//
//  Created by Nicola De Bei on 01/03/23.
//

import Foundation

extension Int {
    func stringTime() -> String {
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
