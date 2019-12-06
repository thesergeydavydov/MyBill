//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
     
    @IBOutlet weak var plateTextField: UITextField!
    @IBOutlet weak var dessertTextField: UITextField!
    @IBOutlet weak var coffeeTextField: UITextField!
    @IBOutlet weak var alcoTextField: UITextField!
    
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var calculateTapped: UIButton!
    @IBOutlet weak var saveTapped: UIButton!
    
    var items : [Item] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        for textField in itemsTextField {
//            textField.addToolBar()
//        }
        plateTextField.addToolBar()
        dessertTextField.addToolBar()
        coffeeTextField.addToolBar()
        alcoTextField.addToolBar()
        tipTextField.addToolBar()
        
        calculateTapped.layer.cornerRadius = calculateTapped.frame.size.height / 2
        saveTapped.layer.cornerRadius = saveTapped.frame.size.height / 2

        
        setupNavigationBarItems()
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
            self.items.append(newItem)
            plateTextField.text = nil
        }
    }
    
    
    
//    @IBAction func addPlateTapped(_ sender: Any) {
//        self.items = plateTextField.text!
//        //vc?.billItem.append(items)
//        performSegue(withIdentifier: "BillList", sender: self)
//
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as! BillListTableViewController
        
//        if segue.identifier == "BillList_1" {
//
//        } else if segue.identifier == "BillList_2" {
//
//        } else if segue.identifier == "BillList_3" {
//
//        }
        
//        billListTVC.billItem = self.items
        billListTVC.delegate = self
    }
    
}


