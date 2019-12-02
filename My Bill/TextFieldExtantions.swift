//
//  TextFieldExtantions.swift
//  My Bill
//
//  Created by Sergey Davydov on 26/11/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    func addToolBar() {

        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(clikedDone))
        let clear = UIBarButtonItem(title: "Сброс", style: .plain, target: self, action: #selector(clikedClear))

        toolBar.setItems([clear, flexSpace,done], animated: true)

        self.inputAccessoryView = toolBar
    }

    @objc func clikedDone() {
        self.endEditing(true)
    }

    @objc func clikedClear() {
        self.text = ""
    }

}
//extension UIButton {
//    func addButtonToolBar() {
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//            let done = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(clikedDone))
//            
//            
//            toolBar.setItems([flexSpace,done], animated: true)
//            
//            self.inputAccessoryView = toolBar
//        }
//        @objc func clikedDone() {
//            self.endEditing(true)
//        }
//}
