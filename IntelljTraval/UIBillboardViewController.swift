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
    
    let imageService = ImageService()
    var imageNames: [Int]? {
        didSet {
            //通过图片数量设置uiscrollview的宽度，只有在contentsize>scrollviewsize的时候才会滑动
            let width = self.view.frame.size.width
            let height = self.view.frame.size.height
            self.billboardScrollView.contentSize = CGSizeMake(width * CGFloat((imageNames?.count)!), height)
            
             //根据图片名称新建imageview，利用网络获取图片，设置到imageview当中.
            for (var i: Int=0; i < imageNames!.count; i++) {
                let imageName = imageNames![i]
                let imageView = UIImageView()
                
                imageView.frame = CGRectMake(CGFloat(i) * width, 0, width, height)
                self.billboardScrollView.addSubview(imageView)
                self.billboardPageControl.numberOfPages = imageNames!.count
                imageService.retrieveImageFromServerOrCache(pictureId: imageName, imageView: imageView)
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.billboardScrollView.delegate = self
        self.billboardPageControl.addTarget(self, action: Selector("changePage:"), forControlEvents: UIControlEvents.ValueChanged)
        //让图片自动循环滑动
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "circulateImage", userInfo: nil, repeats: true)
    }
    
    //当用户手指触动pageControl时会触发changePage
    func changePage(sender: AnyObject?) {
        let page = self.billboardPageControl.currentPage
        self.billboardScrollView.setContentOffset(CGPointMake(self.view.frame.size.width * CGFloat(page), 0), animated: true)
    }
    
    func circulateImage() {
        if self.billboardPageControl.currentPage == (self.billboardPageControl.numberOfPages - 1) {
            self.billboardScrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            self.billboardPageControl.currentPage = 0
        } else {
            self.billboardScrollView.setContentOffset(CGPointMake(self.view.frame.size.width * CGFloat(++self.billboardPageControl.currentPage), 0), animated: true)
        }
    }
    
    //当uiscrollview滑动结束时候，相应的改变pageControl
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offsetX = self.billboardScrollView.contentOffset.x
        let index = offsetX / self.view.frame.size.width
        self.billboardPageControl.currentPage = Int(index)
    }
    
}