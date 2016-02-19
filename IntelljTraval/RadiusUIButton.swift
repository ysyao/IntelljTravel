//
//  RadiusUIButton.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/19.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class RadiusUIButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
}
