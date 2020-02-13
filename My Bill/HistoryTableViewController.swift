//
//  HistoryTableViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 17/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var delegateTB: [BillsEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreDataInfo()
    }
    
    func getCoreDataInfo() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataBill = try? context.fetch(BillsEntity.fetchRequest()) as? [BillsEntity]{
                delegateTB = coreDataBill
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return delegateTB.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "TotalBillSaved")
        cell.detailTextLabel?.text = delegateTB[indexPath.row].date
        cell.textLabel?.text = delegateTB[indexPath.row].price
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        cell.imageView?.image = UIImage(named: "app-mini")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let totalBill = delegateTB[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(totalBill)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
                getCoreDataInfo()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedHistory = delegateTB[indexPath.row]
        performSegue(withIdentifier: "goToDetailHistory", sender: selectedHistory)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailHistoryVC = segue.destination as? DetailHistoryViewController {
            if let detailHistory = sender as? BillsEntity {
                detailHistoryVC.historyDetail = detailHistory
            }
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
    
}
