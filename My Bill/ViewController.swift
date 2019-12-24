//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift
import Foundation

class ViewController: UIViewController {
     
    @IBOutlet weak var menuPadView: UIView!
    @IBOutlet weak var menuPadImage: UIImageView!
    
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

    var totalBills : [BillsEntity] = []
    
    let currentdate = Date()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        plateTextField.addToolBar()
//        dessertTextField.addToolBar()
//        coffeeTextField.addToolBar()
//        alcoTextField.addToolBar()
//        tipTextField.addToolBar()
//        IQKeyboardManager.shared.toolbarDoneBarButtonItemImage = UIImage(named: "app-mini")

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        calculateTapped.layer.cornerRadius = calculateTapped.frame.size.height / 2
        saveTapped.layer.cornerRadius = saveTapped.frame.size.height / 2

        setupNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum()
        calculateTip()
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
        sum()
        calculateTip()
    }
    
    @IBAction func addPlateTF(_ sender: Any) {
        if let text = plateTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = plateTextField.text!
            newItem.image = UIImage(named: "plate-mini")!
            self.items.append(newItem)
            plateTextField.text = nil
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addDessertTapped(_ sender: Any) {
        if let text = dessertTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = dessertTextField.text!
            newItem.image = UIImage(named: "dessert-mini")!
            self.items.append(newItem)
            dessertTextField.text = nil
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addDessertTF(_ sender: Any) {
        if let text = dessertTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = dessertTextField.text!
            newItem.image = UIImage(named: "dessert-mini")!
            self.items.append(newItem)
            dessertTextField.text = nil
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addCoffeeTapped(_ sender: Any) {
        if let text = coffeeTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = coffeeTextField.text!
            newItem.image = UIImage(named: "coffee-mini")!
            self.items.append(newItem)
            coffeeTextField.text = nil
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addCoffeeTF(_ sender: Any) {
       if let text = coffeeTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = coffeeTextField.text!
            newItem.image = UIImage(named: "coffee-mini")!
            self.items.append(newItem)
            coffeeTextField.text = nil
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addAlcoTapped(_ sender: Any) {
        if let text = alcoTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = alcoTextField.text!
            newItem.image = UIImage(named: "alco-mini")!
            self.items.append(newItem)
            alcoTextField.text = nil
            print(newItem.date)
        }
        sum()
        calculateTip()
    }
    
    @IBAction func addAlcoTF(_ sender: Any) {
        if let text = alcoTextField.text, !text.isEmpty {
            let newItem = Item()
            newItem.price = alcoTextField.text!
            newItem.image = UIImage(named: "alco-mini")!
            self.items.append(newItem)
            alcoTextField.text = nil
            print(newItem.date)
        }
        sum()
        calculateTip()
    }
    
    @IBAction func tipTF(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func calculateTapped(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let total = convertCurrencyToInt(input: billLabel.text!)
        let tip = convertCurrencyToInt(input: tipLabel.text!)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let sumBT = BillsEntity(context: context)
            sumBT.price = String(total! + tip!)
            sumBT.date = "\(dateFormatter.string(from: currentdate))"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            loadView()
            viewDidLoad()
            items.removeAll()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as? BillListTableViewController
        billListTVC?.delegate = self
        let historyTVC = segue.destination as? HistoryTableViewController
        historyTVC?.delegateTB = self
    }
    
    func calculateTip() {
        let total = convertCurrencyToInt(input: billLabel.text!)
        let tipPercetage = Int(tipTextField.text!)!
        let tip = total! * tipPercetage / 100
        tipLabel.text = convertIntToCurrency(numb: tip)
    }
    
    func sum() {
        var total = 0
        for item in items {
            total += Int(item.price)!
            }
        billLabel.text = convertIntToCurrency(numb: total)
    }
    
    func convertIntToCurrency(numb:Int) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: numb))!
    }
    
    func convertCurrencyToInt(input: String) -> Int? {
         let formatter = NumberFormatter()
         formatter.numberStyle = .currency
         formatter.locale = Locale.current
         return formatter.number(from: input)?.intValue
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        loadView()
        viewDidLoad()
        items.removeAll()
    }

}
