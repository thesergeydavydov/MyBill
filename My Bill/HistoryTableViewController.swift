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
        
//        sumBillsHTVC()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreDataInfo()
//        sumBillsHTVC()
    }
    
    func getCoreDataInfo() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataBill = try? context.fetch(BillsEntity.fetchRequest()) as? [BillsEntity]{
                delegateTB = coreDataBill
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
        return delegateTB.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "TotalBillSaved")
        cell.detailTextLabel?.text = delegateTB[indexPath.row].date
        cell.textLabel?.text = delegateTB[indexPath.row].price
        if let imageData = delegateTB[indexPath.row].image {
            cell.imageView?.image = UIImage (data: imageData)?.circleMask
        }
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
            let totalBill = delegateTB[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(totalBill)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
             getCoreDataInfo()
            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)

//            sumBillsHTVC()
            }
        }
    }
    
//    func sumBillsHTVC() {
//        var total = 0.00
//        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
//            let sumBills = BillsEntity(context: context)
//            print(sumBills.price)
////            total += Double(sumBills.price!)!
//        }
//        sumBillsLabel.text = convertDoubleToCurrency(numb: total)
//    }
    
    func convertDoubleToCurrency(numb:Double) -> String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: NSNumber(value: numb))!
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

extension UIImage {
var circleMask: UIImage {
    let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
    let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.image = self
    imageView.layer.cornerRadius = square.width/2
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 5
    imageView.layer.masksToBounds = true
    UIGraphicsBeginImageContext(imageView.bounds.size)
    imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
    let result = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return result
    }
}
