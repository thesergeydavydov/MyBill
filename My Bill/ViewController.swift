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
    @IBOutlet weak var dessertTextLable: UITextField!
    @IBOutlet weak var coffieTextLable: UITextField!
    @IBOutlet weak var alcoTextField: UITextField!
    @IBOutlet weak var tipTextField: UITextField!
    @IBOutlet weak var plateTapped: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        plateTextField.addToolBar()
        dessertTextLable.addToolBar()
        coffieTextLable.addToolBar()
        alcoTextField.addToolBar()
        tipTextField.addToolBar()
        

        
        setupNavigationBarItems()
        
    
        
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        

//    deinit {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
//    }
    
//    @objc func keyboardWillChange(notification: NSNotification) {
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
//            view.frame.origin.y = -keyboardRect.height
//        } else {
//            view.frame.origin.y = 0
//
//        }
//
//
        
    }
    
   override func viewDidAppear(_ animated: Bool) {
    
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .scaleAspectFit
//
//        let image = UIImage (named: "ifoody-icon-new1")
//        imageView.image = image
//        navigationItem.titleView = imageView
//
//        var navigateImage = UIImage(named: "history-1.png")
//        navigateImage = navigateImage?.withRenderingMode(.alwaysOriginal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: navigateImage, style:.plain, target: nil, action: nil)
    
}
    
    private func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: UIImage(named: "title_icon-1"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
        
//        let followButton = UIButton(type: .system)
//        followButton.setImage(UIImage(named: "history-1"), for: .normal)
//        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        followButton.contentMode = .scaleAspectFit
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)
    }
    
    
}

