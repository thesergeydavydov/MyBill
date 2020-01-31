//
//  UIView Round6.swift
//  My Bill
//
//  Created by Sergey Davydov on 31/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import Foundation
import UIKit

class Round6View: UIView {
    override func didMoveToWindow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = frame.size.height / 6
    }
}
