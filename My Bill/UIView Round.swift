//
//  UIView Round.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import Foundation
import UIKit

class roundView: UIView {
    override func didMoveToWindow() {
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
    }
}
