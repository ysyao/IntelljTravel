//
//  BillboardViewDelegator.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/24.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

public protocol UIBillboardViewDelegator: NSObjectProtocol {
    func willPresentBillboardUIImages(billboardView: UIBillboardViewController) -> [UIImage]
}
