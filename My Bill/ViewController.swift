//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
    @IBOutlet weak var menuPadView: roundView!
    @IBOutlet weak var menuPadImage: roundImageView!
    
    @IBOutlet weak var plateTextField: UITextField!
    @IBOutlet weak var dessertTextField: UITextField!
    @IBOutlet weak var coffeeTextField: UITextField!
    @IBOutlet weak var alcoTextField: UITextField!
    
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTapped: UIButton!
    
    @IBOutlet weak var photoView: UIImageView!
    
    
    var items : [Item] = []

    var totalBills : [BillsEntity] = []
    
    var photo = UIImagePickerController()
    
    let currentdate = Date()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        photoView.layer.cornerRadius = 14
        
        photo.delegate = self
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        billTapped.layer.cornerRadius = billTapped.frame.size.height / 6
        
        photoView.layer.cornerRadius = photoView.frame.size.height / 2
        photoView.layer.masksToBounds = true

        setupNavigationBarItems()
        
        photoView.image = UIImage(named: "photoview")
        
//        photoView.layer.borderWidth = 1.0
//        self.photoView.layer.borderColor = UIColor(red:180/255, green:169/255, blue:159/255, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum()
        calculateTip()
        totalSum()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as? BillListTableViewController
        billListTVC?.delegate = self
//        let historyTVC = segue.destination as? HistoryTableViewController
//        historyTVC?.delegateTB = self
        }
    
    private func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: UIImage(named: "title_icon-1"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
    }
    
    func calculateTip() {
        if (tipTextField.text!.isEmpty) {
            let tip = 0.00
            return tipLabel.text = convertDoubleToCurrency(numb: tip)
        } else {
        let total = convertCurrencyToDouble(input: billLabel.text!)
        let tipPercetage = Double(tipTextField.text!)!
        let tip = total! * tipPercetage / 100
        tipLabel.text = convertDoubleToCurrency(numb: tip)
        }
    }
    
    func sum() {
        var total = 0.00
        for item in items {
            total += Double(item.price)
            }
        billLabel.text = convertDoubleToCurrency(numb: total)
    }
    
    func totalSum() {
        let total = convertCurrencyToDouble(input: billLabel.text!)
        let tip = convertCurrencyToDouble(input: tipLabel.text!)
        let totalSum = total! + tip!
        totalLabel.text = convertDoubleToCurrency(numb: totalSum)
    }
    
    func showPopUp() {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! PopUpViewController

        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)

        popUpVC.didMove(toParent: self)
    }
    
    func showSavedPopUp() {
        let savePopUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "savedPopUpVCid") as! SavedPopUpViewController

        self.addChild(savePopUpVC)
        savePopUpVC.view.frame = self.view.frame
        self.view.addSubview(savePopUpVC.view)

        savePopUpVC.didMove(toParent: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            photoView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
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
    
    func convertCurrencyToDouble(input: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.number(from: input)?.doubleValue
    }
    
    func convertStringToDouble(input: String) -> Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: input)?.doubleValue
    }
    
    func clearText() {
        items.removeAll()
        billLabel.text = "0.00"
        tipTextField.text = "15"
        tipLabel.text = "0.00"
        totalLabel.text = "0.00"
        photoView.image = UIImage(named: "photoview")
    }
    
    @IBAction func addPlateTapped(_ sender: Any) {
        plateTextField.becomeFirstResponder()
    }

    @IBAction func addPlateTF(_ sender: Any) {
        if let text = convertStringToDouble(input: plateTextField.text!) {
            let newItem = Item()
            newItem.price = text
            newItem.image = UIImage(named: "plate-mini")!
            self.items.append(newItem)
            plateTextField.text = nil
        }
        sum()
        calculateTip()
        totalSum()
    }

    @IBAction func addDessertTapped(_ sender: Any) {
        dessertTextField.becomeFirstResponder()
    }

    @IBAction func addDessertTF(_ sender: Any) {
        if let text = convertStringToDouble(input: dessertTextField.text!) {
            let newItem = Item()
            newItem.price = text
            newItem.image = UIImage(named: "dessert-mini")!
            self.items.append(newItem)
            dessertTextField.text = nil
        }
        sum()
        calculateTip()
        totalSum()
    }

    @IBAction func addCoffeeTapped(_ sender: Any) {
        coffeeTextField.becomeFirstResponder()
    }

    @IBAction func addCoffeeTF(_ sender: Any) {
        if let text = convertStringToDouble(input: coffeeTextField.text!) {
            let newItem = Item()
            newItem.price = text
            newItem.image = UIImage(named: "coffee-mini")!
            self.items.append(newItem)
            coffeeTextField.text = nil
        }
        sum()
        calculateTip()
        totalSum()
    }

    @IBAction func addAlcoTapped(_ sender: Any) {
        alcoTextField.becomeFirstResponder()
    }
    
    @IBAction func addAlcoTF(_ sender: Any) {
        if let text = convertStringToDouble(input: alcoTextField.text!) {
            let newItem = Item()
            newItem.price = text
            newItem.image = UIImage(named: "alco-mini")!
            self.items.append(newItem)
            alcoTextField.text = nil
            print(newItem.date)
        }
        sum()
        calculateTip()
        totalSum()
    }
    
    @IBAction func tipTF(_ sender: Any) {
        calculateTip()
        totalSum()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        let total = convertCurrencyToDouble(input: billLabel.text!)
        let tip = convertCurrencyToDouble(input: tipLabel.text!)
        let bill = convertCurrencyToDouble(input: billLabel.text!)
        let tipPersentage = convertCurrencyToDouble(input: tipTextField.text!)
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let sumBT = BillsEntity(context: context)
            sumBT.price = String(format: "%g", total! + tip!)
            sumBT.total = String(format: "%g", total!)
            sumBT.tip = String(format: "%g", tip!)
            sumBT.bill = String(format: "%g", bill!)
            sumBT.tipPersentage = String(format: "%g", tipPersentage!)
            sumBT.date = "\(dateFormatter.string(from: currentdate))"
            sumBT.image = photoView.image?.jpegData(compressionQuality: 1.0)
//            sumBT.imageMini = photoView.image?.resizeImage(70, opaque: true)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
//            loadView()
//            viewDidLoad()
//            items.removeAll()
            clearText()
            showSavedPopUp()
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
//        loadView()
//        viewDidLoad()
//        items.removeAll()
        clearText()
        viewWillAppear(true)
        showPopUp()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        photo.sourceType = .camera
        present(photo, animated: true, completion: nil)
    }
    
}
//extension UIImage {
//    func resizeImage(_ dimension: CGFloat, opaque: Bool, contentMode: UIView.ContentMode = .scaleAspectFit) -> UIImage {
//        var width: CGFloat
//        var height: CGFloat
//        var newImage: UIImage
//
//        let size = self.size
//        let aspectRatio =  size.width/size.height
//
//        switch contentMode {
//            case .scaleAspectFit:
//                if aspectRatio > 1 {                            // Landscape image
//                    width = dimension
//                    height = dimension / aspectRatio
//                } else {                                        // Portrait image
//                    height = dimension
//                    width = dimension * aspectRatio
//                }
//
//        default:
//            fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
//        }
//
//        if #available(iOS 10.0, *) {
//            let renderFormat = UIGraphicsImageRendererFormat.default()
//            renderFormat.opaque = opaque
//            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
//            newImage = renderer.image {
//                (context) in
//                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//            }
//        } else {
//            UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
//                self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
//                newImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//        }
//
//        return newImage
//    }
//}
