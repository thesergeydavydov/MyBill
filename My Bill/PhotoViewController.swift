//
//  PhotoViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 28/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photosImageView: UIImageView!
    
    var photoViewer : ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        photosImageView = photoViewer?.photoView.image
        
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
