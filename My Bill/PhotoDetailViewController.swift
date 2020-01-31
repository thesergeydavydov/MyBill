//
//  PhotoDetailViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 31/01/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var photoDetailZoomImageView: UIImageView!
    
    var photoHistoryDetail : DetailHistoryViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        photoDetailZoomImageView.image = photoHistoryDetail?.photoDetailImageView.image
       

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
