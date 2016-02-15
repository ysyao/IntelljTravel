//
//  ProductUIImageView.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/13.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class ProductUIImageView: UIImageView {
    override var image: UIImage? {
        didSet {
            //剪裁
//            let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
//            
//            let newImage = self.scaleImage(self.image!, newSize: size)
//            if newImage != nil {
//                self.image = newImage
//            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
                let size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
                
                let newImage = self.scaleImage(self.image!, newSize: size)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if newImage != nil {
                        self.image = newImage
                    }
                })
            }

        }
    }
    
    func scaleImage(image: UIImage, newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return newImage
        }
        return nil
    }
}
