//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit

class roundImageView: UIImageView {
    override func didMoveToWindow() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}

class roundView: UIView {
    override func didMoveToWindow() {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
}


class ViewController: UIViewController {
     
    @IBOutlet weak var menuPadView: roundView!
    @IBOutlet weak var menuPadImage: roundImageView!
    
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
    var totalBills : [TotalBill] = []
    
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
        plateTextField.layer.cornerRadius = plateTextField.frame.size.height / 2
        plateTextField.layer.borderWidth = 0.5
        plateTextField.layer.borderColor = UIColor.lightGray.cgColor
        plateTextField.clipsToBounds = true
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        
        calculateTapped.layer.cornerRadius = calculateTapped.frame.size.height / 6
        saveTapped.layer.cornerRadius = saveTapped.frame.size.height / 6

        setupNavigationBarItems()
        
//        billLabel = delegate?.totalLabel.

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
    
    @IBAction func calculateTapped(_ sender: Any) {
        calculateTip()

    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let sumBT = TotalBill()
        sumBT.priceTB = String(Int(billLabel.text!)! + Int(tipLabel.text!)!)
        sumBT.imageTB = UIImage(named: "app-mini")!
        sumBT.dateTB = "\(dateFormatter.string(from: currentdate))"
        self.totalBills.append(sumBT)
        print(sumBT.priceTB)
        loadView()
        viewDidLoad()
        items.removeAll()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as? BillListTableViewController
        billListTVC?.delegate = self
        let historyTVC = segue.destination as? HistoryTableViewController
        historyTVC?.delegateTB = self
//        historyTVC?.saveBill = billLabel.text!
//        billListTVC.delegateTotal = self
        
    }
    
    func calculateTip() {
        let bill = Double(billLabel.text!)!
        let tipPercetage = Double(tipTextField.text!)!
        let tip = bill * (tipPercetage / 100)
        tipLabel.text = "\(Int(tip))"
        
    }
    
    func sum() {
        var total = 0
        for item in items {
            total += Int(item.price)!
            }
            billLabel.text = "\(total)"
        }
    
            
    
//    func textTotal(text:String?) {
//        billLabel.text = text
//    }
    
//    func refreshButton() {
//        navigationController?.popToRootViewController(animated: true)
//    }
    
    @IBAction func refreshTapped(_ sender: Any) {
//        refreshButton()
        loadView()
        viewDidLoad()
        items.removeAll()
    }
}


