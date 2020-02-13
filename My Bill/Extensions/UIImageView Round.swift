//
//  UIImageView Round.swift
//  My Bill
//
//  Created by Sergey Davydov on 20/12/2019.
//  Copyright © 2019 Sergey Davydov. All rights reserved.
//

import Foundation
import UIKit

class roundImageView: UIImageView {
    override func didMoveToWindow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
