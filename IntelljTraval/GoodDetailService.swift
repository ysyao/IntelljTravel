//
//  GoodDetailService.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/25.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import Alamofire

class GoodDetailService: DataService {
    func getGoodDetail(productId productId: String, type: String, dataServiceResponse: DataServiceResponse<VoidCommonObject, GoodDetail>) -> Request {
        let parameters = [
            "id"    :   productId,
            "type"  :   type
        ]
        
        return sendGetRequest(Constants.IntelljTravalURL.IT_GOODS_DETAILS, parameters: parameters, dataServiceResponse: dataServiceResponse)
    }
}