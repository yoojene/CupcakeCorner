//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Eugene on 30/08/2023.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.orderData.type) {
                        ForEach(Order.types.indices) {  // only use this on static immutable arrays, as mutable obviously can change order
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.orderData.quantity)", value: $order.orderData.quantity, in: 3...20)
                }

                Section {
                    Toggle("Any special requests?" , isOn: $order.orderData.specialRequestEnabled.animation())

                    if order.orderData.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.orderData.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.orderData.addSprinkles)
                    }
                }


                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label : {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }.onAppear {
            print(order.orderData)
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
