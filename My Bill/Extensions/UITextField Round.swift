//
//  UITextField Round.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import Foundation
import UIKit

class roundTextField: UITextField {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
}
