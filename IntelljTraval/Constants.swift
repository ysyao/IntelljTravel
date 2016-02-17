//
//  Constants.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/29.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation

public class Constants {
    static let HOST = "http://115.28.214.63:9988/weixin"
    public struct IntelljTravalURL {
        static let GET_GOODS_LIST: String = HOST + "/hsh/goods/getGoodsListPage"
        static let IT_PICTURE_URL: String = HOST + "/hsh/image/"
        static let IT_GOODS_DETAILS = HOST + "/hsh/goods/getGoodsDetails";
    }
}