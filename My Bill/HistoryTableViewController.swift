//
//  HistoryTableViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 17/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    @IBOutlet weak var sumBillsLabel: UILabel!
    
    var delegateTB: ViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumBillsHTVC()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreDataInfo()
        sumBillsHTVC()
    }
    
    func getCoreDataInfo() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataBill = try? context.fetch(BillsEntity.fetchRequest()) as? [BillsEntity]{
                delegateTB?.totalBills = coreDataBill
                tableView.reloadData()
            }
        }
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return delegateTB!.totalBills.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "TotalBillSaved")
        cell.detailTextLabel?.text = delegateTB!.totalBills[indexPath.row].date
        cell.textLabel?.text = delegateTB!.totalBills[indexPath.row].price
        cell.imageView?.image = UIImage(named: "app-mini")
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let totalBill = delegateTB!.totalBills[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(totalBill)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
             getCoreDataInfo()
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)

            sumBillsHTVC()
            }
        }
    }
    
    func sumBillsHTVC() {
        var total = 0
        if let totalBills = delegateTB?.totalBills {
            for totalBill in totalBills {
                total += Int(totalBill.price!)!
            }
        }
        sumBillsLabel.text = "\(total)"
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
