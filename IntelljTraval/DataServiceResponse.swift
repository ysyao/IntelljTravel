//
//  DataManagerResponse.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/17.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation

class DataServiceResponse<T: CommonObject, V: CommonObject> {
    var success: (genericReturnObject: GenericReturnObject<T, V>) -> ()
    var error: (error: NSError) -> ()
    init(success: (genericReturnObject: GenericReturnObject<T, V>) -> (), error: (error: NSError) -> ()) {
        self.success = success
        self.error = error
    }
}