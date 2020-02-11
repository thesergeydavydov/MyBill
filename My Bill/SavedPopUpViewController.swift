//
//  SavedPopUpViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 23/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class SavedPopUpViewController: UIViewController {
    
    @IBOutlet weak var messageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageView.layer.cornerRadius = 24
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        moveIn()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        moveOut()
    }
    
    func moveIn() {
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut() {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            self.view.removeFromSuperview()
        }
    }
    
}
