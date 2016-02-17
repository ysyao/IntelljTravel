//
//  DataManager.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/31.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DataManager {
    init () {}
    
    func parseList<T: CommonObject>(response: Response<String, NSError>, dataManagerResponse: DataManagerResponse<T>) {
        if response.result.isSuccess {
            if let jsonValue = response.result.value {
                //将获取到的string结果转换成为JSON，方便映射
                let json: JSON = JSON.parse(jsonValue)
                
                let generic = GenericReturnObject<T>()
                //解析json
                let list = generic.parseGenericReturnObject(json).list
                dataManagerResponse.success(commonObjects: list)
            }
        } else {
            dataManagerResponse.error(error: response.result.error!)
        }
    }
    
    func sendGetRequest<T: CommonObject>(url: String, parameters: [String: AnyObject]?, dataManagerResponse: DataManagerResponse<T>) {
        Alamofire.request(.GET, url, parameters: parameters).responseString {
            response in
            if response.result.isSuccess {
                self.parseList(response, dataManagerResponse: dataManagerResponse)
            }
        }
    }
}