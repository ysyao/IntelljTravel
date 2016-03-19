//
//  CartTabelViewCell.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/3/18.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var buyTime: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        title.sizeToFit()
//        buyTime.sizeToFit()
    }
}