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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        tap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped() {
        if scrollView.zoomScale > scrollView.minimumZoomScale {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoZoomView
    }
    
}
