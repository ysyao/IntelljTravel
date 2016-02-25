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

class DataService {
    init () {}
    
    func parseList<T: CommonObject, V: CommonObject>(response: Response<String, NSError>, dataServiceResponse: DataServiceResponse<T, V>) {
        if response.result.isSuccess {
            if let jsonValue = response.result.value {
                //将获取到的string结果转换成为JSON，方便映射
                let json: JSON = JSON.parse(jsonValue)
                
                let generic = GenericReturnObject<T, V>()
                //解析json
                dataServiceResponse.success(genericReturnObject: generic.parseGenericReturnObject(json))
            }
        } else {
            dataServiceResponse.error(error: response.result.error!)
        }
    }
    
    func sendGetRequest<T: CommonObject, V: CommonObject>(url: String, parameters: [String: AnyObject]?, dataServiceResponse: DataServiceResponse<T, V>) -> Request {
        print(url)
        return Alamofire.request(.GET, url, parameters: parameters).responseString {
            response in
            if response.result.isSuccess {
                self.parseList(response, dataServiceResponse: dataServiceResponse)
            }
        }
    }
}