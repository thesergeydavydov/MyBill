//
//  PhotoViewController.swift
//  My Bill
//
//  Created by Sergey Davydov on 03/02/2020.
//  Copyright © 2020 Sergey Davydov. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoZoomView: UIImageView!
    
    
    var photoHistoryDetail: DetailHistoryViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoZoomView.image = photoHistoryDetail?.photoDetailImageView.image
        // Do any additional setup after loading the view.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoZoomView
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
