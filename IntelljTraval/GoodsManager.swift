//
//  GoodsHttpController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/30.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class GoodsManager: DataManager {
    
    
    //*****************************************************************
    // MARK : Get JSON from server
    //*****************************************************************
    internal func getGoods(scenicId scenicId: String, searchContent: String, type: String, sortType: String, page:String, pageSize: String, success: (goods: [Good]) -> Void, error: (error: NSError) -> Void) -> Void {
        let parameters = [
            "scenicId"      : scenicId,
            "searchContent" : searchContent,
            "type"          : type,
            "sortType"      : sortType,
            "page"          : page,
            "pageSize"      : pageSize
        ]
        
        Alamofire.request(.GET, Constants.IntelljTravalURL.GET_GOODS_LIST, parameters: parameters).responseString {
            response in
//            print(response.result.isSuccess)
//            print(response.result.value)
//            print(response.result.error)
            
            if response.result.isSuccess {
                if let goodJson = response.result.value {
                    //将获取到的string结果转换成为JSON，方便映射
                    let json: JSON = JSON.parse(goodJson)
                    
                    //解析json
                    let genericGood: GenericReturnObject<Good> = GenericReturnObject<Good>()
                    let goods: [Good] = genericGood.parseGenericReturnObject(json).list
                    
                    success(goods: goods)
                }
            } else {
                error(error: response.result.error!)
            }
        }
    }
}