//
//  Goods.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/27.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import SwiftyJSON
import Alamofire

public class Good: CommonObject {
    var id: Int?
    var address: String?
    var salesNumber: String?
    var scenicLevel: String?
    var merchantName: String?
    var grade: Int?
    var picId: Int?
    var salePrice: Float?
    var commentNumber: Int?
    var intro: String?
    var goodsName: String?
    
    public required init() {
        
    }
    
    init(id: Int, address: String, scenicLevel: String, merchantName: String, grade: Int, picId: Int, salePrice: Float, commentNumber: Int, intro: String, goodsName: String) {
        self.id = id
        self.address = address
        self.merchantName = merchantName
        self.grade = grade
        self.scenicLevel = scenicLevel
        self.picId = picId
        self.salePrice = salePrice
        self.commentNumber = commentNumber
        self.intro = intro
        self.goodsName = goodsName
    }
    
    //*****************************************************************
    // MARK : JSON parse into object
    //*****************************************************************
    public func parseObject(obj: JSON) -> CommonObject {
        let good: Good = Good()
        if let id = obj["id"].int {
            good.id = id
        }
        
        if let address: String = obj["address"].string {
            good.address = address
        }
        
        if let merchantName: String = obj["merchantName"].string {
            good.merchantName = merchantName
        }
        
        if let grade = obj["grade"].int {
            good.grade = grade
        }
        
        if let picId = obj["picId"].int {
            good.picId = picId
        }
        
        if let salePrice = obj["salePrice"].float {
            good.salePrice = salePrice
        }
        
        if let commentNumber = obj["commentNumber"].int {
            good.commentNumber = commentNumber
        }
        
        if let intro: String = obj["intro"].string {
            good.intro = intro
        }
        
        if let goodsName: String = obj["goodsName"].string {
            good.goodsName = goodsName
        }
        return good
    }
}