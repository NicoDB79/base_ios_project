//
//  OrderListView.swift
//  BaseProject
//
//  Created by Nicola De Bei on 03/02/25.
//  
//

import SwiftUI

struct OrderListView: View {
    
    @ObservedObject var model: OrderListModels
    var orderSelected: ((String) ->())?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Server URL: \(model.serverUrl)")
                .padding(10)
            List(model.uiOrders) { order in
                Text(order.code)
                    .onTapGesture {
                        orderSelected?(order.code)
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct  OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = OrderListModels()
        model.uiOrders = [UIOrder(code: "ABC123"), UIOrder(code: "DEF456")]
        model.serverUrl = Bundle.main.serverURLString ?? "Undefined"
        return OrderListView(model: model)
    }
}
