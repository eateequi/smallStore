//
//  Created by Ateequi, Ehsan on 9/30/17.
//  Copyright © 2017 Ehsan M. Ateequi. All rights reserved.
//

import Foundation

protocol Taxable {
    var taxPercentage: Double { get }
}

protocol Discountable {
    var discountPercentage: Double { get }
}

class ShopItem {
    var name: String
    var price: Double
    init(name: String, price: Double) {
        self.name = name;
        self.price = price
    }
    
    func cost() -> Double {
        return self.price
    }
}

class Food: ShopItem, Discountable {
    var discountPercentage: Double
    init(name: String, price:Double, discountPercentage: Double) {
        self.discountPercentage = discountPercentage
        super.init(name: name, price: price)
    }
    
    override func cost() -> Double {
        return super.cost() - price * discountPercentage / 100
    }
}

class Gas: ShopItem, Discountable, Taxable {
    var discountPercentage: Double
    var taxPercentage: Double
    init(name: String, price:Double, discountPercentage: Double, taxPercentage: Double) {
        self.discountPercentage = discountPercentage
        self.taxPercentage = taxPercentage
        super.init(name: name, price: price)
    }
    
    override func cost() -> Double {
        return super.cost() + (price * taxPercentage / 100) - (price * discountPercentage / 100)
    }
}

class Customer {
    var fullName: String
    var purchasedItems: [ShopItem]
    lazy var purchaseCost: Double  = {
        var cost = 0.0
        for item in self.purchasedItems {
            cost += item.cost()
        }
        return cost
    }()
    
    init(fullName: String, purchasedItems: [ShopItem]) {
        self.fullName = fullName
        self.purchasedItems = purchasedItems
    }
}

// Mark - Mock Customer Data

class ShoppingItems  {
    
    let customer1 = Customer(fullName: "John Smith", purchasedItems: [ItemGenerator.apple, ItemGenerator.regular, ItemGenerator.coffee])
    let customer2 = Customer(fullName: "Jane Smith", purchasedItems: [ItemGenerator.banana, ItemGenerator.premium])
    let customer3 = Customer(fullName: "Little Johnny", purchasedItems: [ItemGenerator.chipCookies, ItemGenerator.sandwitch])
    let customer4 = Customer(fullName: "Grandpa", purchasedItems: [ItemGenerator.coffee, ItemGenerator.ensure])
    
    func customers() -> [Customer] {
        return [customer1, customer2, customer3, customer4]
    }
}

// Mark - Simple Mock Data for items.  Can be read from a Database with enum and updatable tax and discount percentages

struct ItemGenerator {
    static let coffee = Food(name: "Coffee", price: 3.45, discountPercentage: 0.0)
    static let banana = Food(name: "Banana", price: 12.00, discountPercentage: 0.0)
    static let regular = Gas(name: "Regular Gas", price: 45.45, discountPercentage: 5, taxPercentage: 5.0)
    static let apple = Food(name: "Apples", price: 18.00, discountPercentage: 10.0)
    static let premium = Gas(name: "Premium Gas", price: 65.34, discountPercentage: 7, taxPercentage: 5.0)
    static let chipCookies = Food(name: "Chocholate Chip Cookies", price: 3.45, discountPercentage: 10.00)
    static let sandwitch = Food(name: "Hamburger", price: 6.25, discountPercentage: 0.00)
    static let ensure = Food(name: "Ensure with Regularity", price: 25.25, discountPercentage: 8.00)


}

