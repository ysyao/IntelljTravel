//
//  CommonObject.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/30.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol CommonObject {
    //通过此方法来解析json，有效的和GenericReturnObject结合起来
    func parseObject(obj: JSON) -> CommonObject
    init()
}