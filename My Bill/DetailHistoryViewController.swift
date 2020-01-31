//
//  DetailHistoryViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 29/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class DetailHistoryViewController: UIViewController {

    @IBOutlet weak var photoDetailImageView: roundImageView!
    @IBOutlet weak var billDetailLabel: UILabel!
    @IBOutlet weak var tipPercentageDetailLabel: UILabel!
    @IBOutlet weak var tipDetailLabel: UILabel!
    @IBOutlet weak var totalDetailLabel: UILabel!
  
    @IBOutlet weak var billBackgroundColorView: Round6View!
    @IBOutlet weak var tipPersentageBGCView: Round6View!
    @IBOutlet weak var tipBGCView: Round6View!
    @IBOutlet weak var totalBGCView: Round6View!
    
    var historyDetail : BillsEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = historyDetail?.date
        
        if let image = historyDetail?.image {
            photoDetailImageView.image = UIImage(data: image)
        }
        
        if let priceHistory = historyDetail?.bill {
            billDetailLabel.text = convertDoubleToCurrency(numb: Double(priceHistory)!)
            
        }
        
        if let priceHistory = historyDetail?.tipPersentage {
            tipPercentageDetailLabel.text = priceHistory
        }
        
        if let priceHistory = historyDetail?.tip {
            tipDetailLabel.text = convertDoubleToCurrency(numb: Double(priceHistory)!)
           }
        
        if let priceHistory = historyDetail?.price {
            totalDetailLabel.text = convertDoubleToCurrency(numb: Double(priceHistory)!)
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func convertStringToDouble(input: String) -> Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: input)?.doubleValue
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
