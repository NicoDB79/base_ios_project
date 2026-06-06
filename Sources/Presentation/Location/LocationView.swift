//
//  LocationView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 07/02/25.
//  
//

import SwiftUI

struct LocationView: View {
    
    @StateObject var model: LocationModels
    var callback: (() ->())?
    
    var body: some View {
        VStack(spacing: 40) {
            Text("LocationView")
            Text(model.uiLocation.latitude)
            Text(model.uiLocation.longitude)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct  LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(model:  LocationModels())
    }
}
