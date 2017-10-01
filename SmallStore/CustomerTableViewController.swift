//
//  Created by Ateequi, Ehsan on 9/30/17.
//  Copyright © 2017 Ehsan M. Ateequi. All rights reserved.
//

import UIKit

class CustomerTableViewController: UITableViewController {
    
    let cellIdentifier = "ItemCell"
    
    // Mark - Table View Data Source.  Declared lazy could be very large and better be loaded when needed

    lazy var customers: [Customer] = {
        ShoppingItems().customers()
    }()
    
    
    // Mark - UITableView Delegate Methods.
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return customers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let customer = customers[section]
        return customer.purchasedItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let customer = customers[indexPath.section]
        let purchasedItem = customer.purchasedItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        
        // Mark - Highlight Gas purcheses
        cell.backgroundColor = (purchasedItem is Gas) ? .yellow : .white
        cell.textLabel?.text = purchasedItem.name
        cell.detailTextLabel?.text = "\(purchasedItem.price.toCurrency)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let customer = customers[section]
        return " \(customer.fullName)"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let customer = customers[section]
        return "Total purchase: \(customer.purchaseCost.toCurrency) - Tax and discount included"

    }

}

extension Double {
    var toCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: self as NSNumber)!
    }
}
