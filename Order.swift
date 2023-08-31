//
//  Order.swift
//  CupcakeCorner
//
//  Created by Eugene on 30/08/2023.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false { // automatically turn off extras if special requests are turned off
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
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
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
    }
    
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)

    }
    
    
    

}
