//
//  Order.swift
//  CupcakeCorner
//
//  Created by Eugene on 30/08/2023.
//

import SwiftUI

class Order: ObservableObject {
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    
    struct OrderData: Codable { // This is a data struct, which is then passed around by the ObservableObject class wrapper.  Removes the need for the additional codable gumf on a Codable conformance class
        // A more generic way to do it also here: https://www.swiftjectivec.com/observing-structs-swiftui/
        
        var type = 0
        var quantity = 3
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        
        var extraFrosting = false
        var addSprinkles = false
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            let whitespaceRegex = try! Regex("\\s")
            let anyCharRegex = try! Regex("[a-zA-Z0-9]")
            
            let nameCond: Bool = (name.contains(whitespaceRegex) && !name.contains(anyCharRegex)) || name.isEmpty
            let addressCond: Bool = (streetAddress.contains(whitespaceRegex) && !streetAddress.contains(anyCharRegex)) || streetAddress.isEmpty
            let zipCond: Bool = (zip.contains(whitespaceRegex) && !zip.contains(anyCharRegex)) || zip.isEmpty
            
            if nameCond || addressCond || zipCond {
                return false
            }
            return true
        }
        
        var cost: Double {
            // £2 per cake
            var cost = Double(quantity) * 2
            
            // complicated cakes cost more
            
            cost += (Double(type) / 2)
            
            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }
            
            
            // 50c for sprinkles
            
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
            
        }
    }
    
 
 @Published var orderData = OrderData() // only need 1 @Published property

    
    

}
