//
//  OrderDetailView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import SwiftUI

struct OrderDetailView: View {
    
    @StateObject var model: OrderDetailModels
    var callback: (() ->())?
    
    var body: some View {
        VStack(spacing: 40) {
            Text(model.uiOrder.code)
            Button("button") {
                callback?()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct  OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(model:  OrderDetailModels())
    }
}
