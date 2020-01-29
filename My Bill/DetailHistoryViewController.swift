//
//  DetailHistoryViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 29/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class DetailHistoryViewController: UIViewController {

    @IBOutlet weak var photoDetailImageView: UIImageView!
    
    var historyDetail : BillsEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = historyDetail?.image {
            photoDetailImageView.image = UIImage(data: image)
        }
        // Do any additional setup after loading the view.
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
