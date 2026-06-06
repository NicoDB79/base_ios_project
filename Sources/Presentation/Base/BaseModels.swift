//
//  BaseModels.swift
//  iOSBaseProject
//
//  Created by Nicola De Bei on 16/12/21.
//

import Foundation

enum LoadingState {
    case none
    case loading
    case completed
    case error(_ message: String)
}
