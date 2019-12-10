//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit


class ViewController: UIViewController, DataDelegate {
     
    @IBOutlet weak var plateTextField: UITextField!
    @IBOutlet weak var dessertTextField: UITextField!
    @IBOutlet weak var coffeeTextField: UITextField!
    @IBOutlet weak var alcoTextField: UITextField!
    
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var calculateTapped: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var saveTapped: UIButton!
    
    var items : [Item] = []
//    var delegate: BillListTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        plateTextField.addToolBar()
//        dessertTextField.addToolBar()
//        coffeeTextField.addToolBar()
//        alcoTextField.addToolBar()
//        tipTextField.addToolBar()
        
        calculateTapped.layer.cornerRadius = calculateTapped.frame.size.height / 2
        saveTapped.layer.cornerRadius = saveTapped.frame.size.height / 2

        setupNavigationBarItems()
        
//        billLabel = delegate?.totalLabel
        
    }
    
   override func viewDidAppear(_ animated: Bool) {
    
}
    
    private func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: UIImage(named: "title_icon-1"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
    }
    @IBAction func addPlateTapped(_ sender: Any) {
        if let text = plateTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = plateTextField.text!
            newItem.image = UIImage(named: "plate-mini")!
            self.items.append(newItem)
            plateTextField.text = nil
            
        }
    }
    @IBAction func addDessertTapped(_ sender: Any) {
        if let text = dessertTextField.text, !text.isEmpty {
                  let newItem = Item()
                  newItem.price = dessertTextField.text!
                  newItem.image = UIImage(named: "dessert-mini")!
                  self.items.append(newItem)
                  dessertTextField.text = nil
              }
    }
    @IBAction func addCoffeeTapped(_ sender: Any) {
        if let text = coffeeTextField.text, !text.isEmpty {
                  let newItem = Item()
                  newItem.price = coffeeTextField.text!
                  newItem.image = UIImage(named: "coffee-mini")!
                  self.items.append(newItem)
                  coffeeTextField.text = nil
              }
    }
    @IBAction func addAlcoTapped(_ sender: Any) {
        if let text = alcoTextField.text, !text.isEmpty {
                  let newItem = Item()
                  newItem.price = alcoTextField.text!
                  newItem.image = UIImage(named: "alco-mini")!
                  self.items.append(newItem)
                  alcoTextField.text = nil
              }
    }
    
    @IBAction func calculateTapped(_ sender: Any) {
        
//        print(billLabel.text!)
//        print(tipTextField.text!)
        
        let bill = Int(billLabel.text!)!
        let tipPercetage = Int(tipTextField.text!)!
        
        let tip = bill * (tipPercetage / 100)
        
        tipLabel.text = "Tip: $\(Int(tip))"
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as! BillListTableViewController
        billListTVC.delegate = self
        billListTVC.delegateTotal = self
    }
    
    func textTotal(text:String?) {
        billLabel.text = text
    }
    

}


