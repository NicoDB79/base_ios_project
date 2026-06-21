//
//  LocationModels.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//  
//

import UIKit

struct UILocation {
    var latitude: String = ""
    var longitude: String = ""
}

class LocationModels: BaseModels {
    @Published var uiLocation = UILocation()
}
