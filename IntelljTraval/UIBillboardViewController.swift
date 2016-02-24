//
//  UIBillboardViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/24.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit
public class UIBillboardViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var billboardScrollView: UIScrollView!
    @IBOutlet weak var billboardPageControl: UIPageControl!
    public weak var delegator: UIBillboardViewDelegator?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.billboardScrollView.delegate = self
        
        if delegator != nil {
            if let images = delegator?.willPresentBillboardUIImages(self) {
                createUIImageViews(images)
                self.billboardPageControl.numberOfPages = images.count
            }
        }
    }
    
    private func createUIImageViews(images: [UIImage]) {
        for(var i: Int=0; i < images.count; i++) {
            let image = images[i]
            let imageView = UIImageView(image: image)
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            imageView.frame = CGRectMake(CGFloat(i) * width, 0, width, height)
            self.billboardScrollView.addSubview(imageView)
        }
    }
    
    @IBAction func pageIndict(sender: UIPageControl) {
        let currentPage = self.billboardPageControl.currentPage
        self.billboardScrollView.contentOffset = CGPoint(x: CGFloat(currentPage) * self.view.frame.size.width, y: 0)
    }
    
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offsetX = self.billboardScrollView.contentOffset.x
        let index = offsetX / self.view.frame.size.width
        self.billboardPageControl.currentPage = Int(index)
    }
    
}