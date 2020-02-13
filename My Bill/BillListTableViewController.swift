//
//  BillListTableViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 05/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit

class BillListTableViewController: UITableViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    
    var delegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumTVC()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate!.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "BillRow")
        cell.detailTextLabel?.text = String(format: "%g", delegate!.items[indexPath.row].price)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        if #available(iOS 13.0, *) {
            cell.detailTextLabel?.textColor = .label
        } else {
            cell.detailTextLabel?.textColor = .black
            // Fallback on earlier versions
        }
        cell.imageView?.image = delegate!.items[indexPath.row].image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate!.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            sumTVC()
        }
        
    }
    
    func convertDoubleToCurrency(numb:Double) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: numb))!
    }
    
    func sumTVC() {
        var total = 0.00
        if let items = delegate?.items {
            for item in items {
                total += Double(item.price)
            }
        }
        totalLabel.text = convertDoubleToCurrency(numb: total)
    }
    
}
