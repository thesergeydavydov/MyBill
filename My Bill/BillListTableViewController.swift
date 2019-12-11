//
//  BillListTableViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 05/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit

protocol DataDelegate: class {
    func textTotal(text:String?)
    
}

class BillListTableViewController: UITableViewController {

    @IBOutlet weak var totalLabel: UILabel!
    
    var delegate: ViewController?
    var delegateTotal: DataDelegate?
    
    func sum() {
        var total = 0
        if let items = delegate?.items {
            for item in items {
                total += Int(item.price)!
            }
        }
        
        totalLabel.text = "\(String(total))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sum()
         
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return delegate!.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BillRow", for: indexPath)
        cell.textLabel?.text = delegate!.items[indexPath.row].price
        cell.imageView?.image = delegate!.items[indexPath.row].image
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
            delegate!.items.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)

            sum()
        }

    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            delegateTotal?.textTotal(text: totalLabel?.text)
            
        }
    }
   
    func backButtonClicked(sender: UIBarButtonItem) {
    
    self.navigationController?.popViewController(animated: true)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! ViewController
//        vc.delegate = totalLabel.text!
//    }


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
