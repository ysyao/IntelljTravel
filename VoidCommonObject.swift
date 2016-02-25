//
//  VoidCommonObject.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/25.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import SwiftyJSON

class VoidCommonObject: CommonObject {
    required init(){}
    func parseObject(obj: JSON) -> CommonObject {
        return VoidCommonObject()
    }
}