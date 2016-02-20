//
//  HexUIColor.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/20.
//  Copyright © 2016年 yishiyao. All rights reserved.
//
import UIKit

class HexUIColor: UIColor {
    struct HexUIColorItems {
        static let PrimaryColor = 0x33CC66
        static let DarkerPrimaryColor = 0x339966
        static let LighterPrimaryColor = 0xCCFFCC
        static let PrimaryGray = 0xE8E8E8
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}