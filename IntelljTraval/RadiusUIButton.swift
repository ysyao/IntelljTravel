//
//  RadiusUIButton.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/19.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

@IBDesignable
class RadiusUIButton: UIButton {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
