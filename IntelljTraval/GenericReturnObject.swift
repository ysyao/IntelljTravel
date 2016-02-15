//
//  GenericReturnObject.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/30.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import SwiftyJSON

public class GenericReturnObject<T: CommonObject> {
    var obj: AnyObject?
    lazy var list: [T] = [T]()
    var rn: String?
    var ri: NSObject?
    
    public func parseGenericReturnObject(resultJson: JSON) -> GenericReturnObject<T> {
        if resultJson != nil {
            if let listJson = resultJson["list"].array {
                for tJson in listJson {
                    let object: T! = T()
                    self.list.append(object.parseObject(tJson) as! T)
                }
            }
            
            if let obj: AnyObject = resultJson["obj"].object {
                self.obj = obj
            }
            
            if let rn = resultJson["rn"].string {
                self.rn = rn
            }
            
            if let ri: AnyObject = resultJson["ri"].object {
                self.ri = ri as? NSObject
            }
        }
        return self
    }
}