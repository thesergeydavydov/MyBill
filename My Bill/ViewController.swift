//
//  ViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import UIKit
import Foundation

struct Gradients: Decodable {
    var name: String
    var colors: [String]
}

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
    @IBOutlet weak var photoPadImageView: UIImageView!
    
    var items : [Item] = []
    
    var totalBills : [BillsEntity] = []
    
    var photo = UIImagePickerController()
    
    var counter = 0
    
    let currentdate = Date()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo.delegate = self
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        billTapped.layer.cornerRadius = billTapped.frame.size.height / 6
        
        photoView.layer.cornerRadius = photoView.frame.size.height / 2
        photoView.layer.masksToBounds = true
        
        photoPadImageView.layer.cornerRadius = photoPadImageView.frame.size.height / 2
        photoPadImageView.layer.masksToBounds = true
        
        setupNavigationBarItems()
        
        photoView.image = UIImage(named: "photoview")
        
        setGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sum()
        calculateTip()
        totalSum()
        setGradientBackground()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billListTVC = segue.destination as? BillListTableViewController
        billListTVC?.delegate = self
    }
    
    private func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: UIImage(named: "title_icon-1"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
    }
    
    func setGradientBackground() {
        let jsonUrlString = "https://raw.githubusercontent.com/ghosh/uiGradients/master/gradients.json"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let gradients = try JSONDecoder().decode([Gradients].self, from: data)
                let newGradient = gradients[self.counter]
                
                let newGradient1 = gradients[self.counter].colors[1]
                let newGradient2 = gradients[self.counter].colors[0]
                
                print(newGradient)
                print(newGradient1)
                print(newGradient2)
                
                DispatchQueue.main.sync {
                    let colorTop =  UIColor(hexString: "\(newGradient1)").cgColor
                    let colorBottom = UIColor(hexString: "\(newGradient2)").cgColor

                    let gradientLayer = CAGradientLayer()
                    gradientLayer.colors = [colorTop, colorBottom]
                    gradientLayer.locations = [0.0, 1.0]
                    gradientLayer.frame = self.photoPadImageView.bounds
                    
                    self.photoPadImageView.layer.addSublayer(gradientLayer)
                }
                self.counter += 1
                if self.counter > gradients.count {
                    self.counter = 0
                }
                
            } catch let jsonError {
                print("Error", jsonError)
            }
        }.resume()
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
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            
            clearText()
            showSavedPopUp()
            setGradientBackground()
        }
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        clearText()
        showPopUp()
        setGradientBackground()
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        photo.sourceType = .camera
        present(photo, animated: true, completion: nil)
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
