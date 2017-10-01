//
//  Created by Ateequi, Ehsan on 9/30/17.
//  Copyright © 2017 Ehsan M. Ateequi. All rights reserved.
//

import XCTest
@testable import SmallStore

class SmallStoreTests: XCTestCase {
    var sut: ShoppingItems = ShoppingItems()
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_ShoppingItems_Count_Is2() {
        XCTAssert(sut.customers().count == 4)
    }
    
    func test_JaneSmith_Is_A_Customer() {
        let customers = sut.customers()
        let customer = customers.first{ x in x.fullName == "Jane Smith" }
        XCTAssertNotNil(customer)

    }
    
    func test_John_TotalPurchase_Is_Less_Than_Jane() {
        let _johnPurchase = sut.customer1.purchaseCost
        let _janePurchase = sut.customer2.purchaseCost
        XCTAssert(_johnPurchase < _janePurchase)
    }
    
    func test_GrandPa_Bought_His_Ensure() {
        let customers = sut.customers()
        let granny = customers.first{ x in x.fullName == "Grandpa" }
        let itemsPurchased = granny?.purchasedItems.first { x in x.name == "Ensure with Regularity" }
        XCTAssertNotNil(itemsPurchased)
        

    }
}
