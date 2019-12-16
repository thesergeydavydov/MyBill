//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit


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
//    var delegate: BillListTableViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        plateTextField.addToolBar()
//        dessertTextField.addToolBar()
//        coffeeTextField.addToolBar()
//        alcoTextField.addToolBar()
//        tipTextField.addToolBar()
        
        calculateTapped.layer.cornerRadius = calculateTapped.frame.size.height / 6
        saveTapped.layer.cornerRadius = saveTapped.frame.size.height / 6

        setupNavigationBarItems()
        
        menuPadView.clipsToBounds = false
        menuPadView.layer.shadowColor = UIColor.lightGray.cgColor
        menuPadView.layer.shadowOpacity = 0.4
        menuPadView.layer.shadowOffset = CGSize.zero
        menuPadView.layer.shadowRadius = 10
        menuPadView.layer.shadowPath = UIBezierPath(roundedRect: menuPadView.bounds, cornerRadius: 10).cgPath
        
        menuPadImage.backgroundColor = UIColor.white
        menuPadImage.clipsToBounds = true
        menuPadImage.layer.cornerRadius = 10
//        menuPadImage.layer.shadowColor = UIColor.darkGray.cgColor
//        menuPadImage.layer.shadowRadius = 10
//        menuPadImage.layer.shadowOpacity = 1
//        menuPadImage.layer.shadowOffset = CGSize(width: 10, height: 10)
        
//        billLabel = delegate?.totalLabel.
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum()
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
        sum()
    }
    
    @IBAction func calculateTapped(_ sender: Any) {
        
        print(billLabel.text!)
        print(tipTextField.text!)
                
                let bill = Double(billLabel.text!)!
                let tipPercetage = Double(tipTextField.text!)!
                
                let tip = bill * (tipPercetage / 100)
                
                tipLabel.text = "\(Int(tip))"
        print(tip)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as! BillListTableViewController
        billListTVC.delegate = self
//        billListTVC.delegateTotal = self
        
    }
    
    func sum() {
        var total = 0
        for item in items {
            total += Int(item.price)!
            }
            billLabel.text = "\(String(total))"
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


