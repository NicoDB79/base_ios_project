//
//  Bool+Extension.swift
//  BaseProject
//
//  Created by Nicola De Bei on 08/02/23.
//

import Foundation
import SwiftUI

extension Bool {
    func counterNameColorIfCorrectBottle() -> Color {
        self ? Asset.Colors.textMain.swiftUIColor : Asset.Colors.textFailure.swiftUIColor
    }
}
