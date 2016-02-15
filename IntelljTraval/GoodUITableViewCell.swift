//
//  GoodTableViewCell.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/30.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class GoodUITableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var goodImageView: UIImageView!
    
    //goodImageView当中的图片，设置这个属性的目的是能够让cell在设置图片之前剪裁图片size，
    //好让整个表格的高度看起来合适。
    var goodImage: UIImage? {
        didSet {
            //剪裁
            let size = CGSize(width: self.goodImageView.frame.size.width, height: self.goodImageView.frame.size.height)
            
            let newImage = self.scaleImage(self.goodImage!, newSize: size)
            if newImage != nil {
                self.goodImageView.image = newImage
            } else {
                self.goodImageView.image = self.goodImage
            }
            
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
//                let size = CGSize(width: self.goodImageView.frame.size.width, height: self.goodImageView.frame.size.height)
//                
//                let newImage = self.scaleImage(self.goodImage!, newSize: size)
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    if newImage != nil {
//                        self.goodImageView.image = newImage
//                    } else {
//                        self.goodImageView.image = self.goodImage
//                    }
//                })
//            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.userInteractionEnabled = false
        detailLabel.userInteractionEnabled = false
        goodImageView.userInteractionEnabled = false
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
