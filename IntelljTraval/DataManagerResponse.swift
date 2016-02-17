//
//  DataManagerResponse.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/17.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation

class DataManagerResponse<T: CommonObject> {
    var success: (commonObjects: [T]) -> ()
    var error: (error: NSError) -> ()
    init(success: (commonObjects: [T]) -> (), error: (error: NSError) -> ()) {
        self.success = success
        self.error = error
    }
}