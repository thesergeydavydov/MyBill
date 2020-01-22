//
//  PopUpViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 22/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageView.layer.cornerRadius = 24
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
