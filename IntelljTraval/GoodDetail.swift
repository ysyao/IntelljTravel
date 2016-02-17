//
//  GoodDetail.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/16.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import SwiftyJSON
import Alamofire

class GoodDetail: CommonObject{
//    "obj": {
//    "phone": null,
//    "lng": null,
//    "city": "阿坝州",
//    "id": 13,
//    "hotelName": null,
//    "province": "四川省",
//    "startPurchaseDate": "2015年04月01日",
//    "grade": 0,
//    "merchantName": "阿布氇孜藏餐厅",
//    "hotelType": null,
//    "lat": null,
//    "popularity": 19,
//    "scenicName": "九寨沟神仙池",
//    "goodsType": "06",
//    "purchaseNotes": "预定时间：\n您最晚要在游玩当日05:00前下单，请尽早预订。\n消费时间：\n您的消费时间将依据您在预订商品时填写的预订消费时间，请合理安排出行。\n消费地点：\n阿布氇孜藏餐厅\n发票说明：\n服务费无发票。\n退改规则：\n商品一经支付完成，不退不改。\n温馨提示：\n在接受服务过程中，可随时通过400-004-6767热线电话进行业务咨询。",
//    "imageName": [
//    214
//    ],
//    "merchantID": 38,
//    "scenicLevel": "AAAAA",
//    "intro": "适合2-3人用餐\n菜品如下：\n\n主食1份：藏面\n\n热菜2份：昌都石爆牛柳、糌粑土豆泥\n\n凉菜1份：人生果扒菜心\n\n汤一份\n\n阿布氇孜藏餐厅，汉语意思就是牧羊人。在九寨沟经营了10年，并与2014年在大理双廊开了另一家分店，店内所有的装修设计、彩绘、雕刻镂空都是十分考究，就连做装饰、陈列藏族风情手串等饰品的摆柜都装点的恰到好处，色彩浓郁却不失庄重，所有这一切都由店家亲自设计参与。餐内从菜色、摆盘到所使用的盘子，统一的藏式风格。酥油茶、青稞酒，藏族的特色饮品，用特制的绿松石壶盛装，配上喷香的糌粑，更加醇香可口。青稞酒藏族同胞最爱的酒品，用上等的青稞加冰糖精心酿造，绵甜清爽、口感独特。\n\n店里的特色菜值得——品尝。藏家牛排，入口细嚼，牦牛肉的嚼劲里参着特制的香料味道。藏家烤饼，金黄的皮夹着高原的土豆醇香可口，回味无穷。手抓牦牛肉、羊肉，口感细腻肉质细嫩，店家对食材都经过严密的删选和讲究，让古老的藏餐更适合现代人的口感，各种美味土豆烤牦牛肉、素卷饼、和尚包、再来一碗点缀着人参果的牦牛酸奶拌饭，实在是极美的享受。末了，藏族阿哥或阿妹高歌一曲，献上洁白的哈达，祝福一声扎西德勒。“阿布氇孜”的美味洗去你一路风尘，喝一口青稞酒，好好享受藏式奢侈美食对您味蕾的抚慰。",
//    "endPurchaseDate": "2016年12月30日",
//    "address": "",
//    "roomType": null,
//    "salePrice": 280,
//    "goodsName": "九寨沟-阿布氇孜2-3人精品藏餐套餐",
//    "interficeType": "0"
//    }
    var phone: String?
    var lng: String?
    var city: String?
    var id: Int?
    var hotelName: String?
    var province: String?
    var startpurchaseDate: String?
    var grade: Int?
    var merchantName: String?
    var hotelType: String?
    var lat: String?
    var popularity: Int?
    var scenicName: String?
    var goodsType: String?
    var purchaseNotes:String?
    var imageName: [Int]?
    var merchantID: Int?
    var scenicLevel: String?
    var intro: String?
    var endPurchaseDate: String?
    var address: String?
    var roomType: String?
    var salePrice: Int?
    var goodsName: String?
    var interficeType: String?
    
    required init() {

    }
    
    func parseObject(obj: JSON) -> CommonObject {
        let goodDetail = GoodDetail()
        if let phone = obj["phone"].string {
            goodDetail.phone = phone
        }
        if let lng = obj["lng"].string {
            goodDetail.lng = lng
        }
        if let city = obj["city"].string {
            goodDetail.city = city
        }
        if let id = obj["id"].int {
            goodDetail.id = id
        }
        if let hotelName = obj["hotelName"].string {
            goodDetail.hotelName = hotelName
        }
        if let province = obj["province"].string {
            goodDetail.province = province
        }
        if let startpurchaseDate = obj["startpurchaseDate"].string {
            goodDetail.startpurchaseDate = startpurchaseDate
        }
        if let grade = obj["grade"].int {
            goodDetail.grade = grade
        }
        if let merchantName = obj["merchantName"].string {
            goodDetail.merchantName = merchantName
        }
        if let hotelType = obj["hotelType"].string {
            goodDetail.hotelType = hotelType
        }
        if let lat = obj["lat"].string {
            goodDetail.lat = lat
        }
        if let popularity = obj["popularity"].int {
            goodDetail.popularity = popularity
        }
        if let scenicName = obj["scenicName"].string {
            goodDetail.scenicName = scenicName
        }
        if let purchaseNotes = obj["purchaseNotes"].string {
            goodDetail.purchaseNotes = purchaseNotes
        }
        if let goodsType = obj["goodsType"].string {
            goodDetail.goodsType = goodsType
        }
        if let imageName: [Int] = (obj["imageName"].arrayObject as! [Int]) {
            goodDetail.imageName = imageName
        }
        if let merchantID = obj["merchantID"].int {
            goodDetail.merchantID = merchantID
        }
        if let scenicLevel = obj["scenicLevel"].string {
            goodDetail.scenicLevel = scenicLevel
        }
        if let intro = obj["intro"].string {
            goodDetail.intro = intro
        }
        if let endPurchaseDate = obj["endPurchaseDate"].string {
            goodDetail.endPurchaseDate = endPurchaseDate
        }
        if let address = obj["address"].string {
            goodDetail.address = address
        }
        if let roomType = obj["roomType"].string {
            goodDetail.roomType = roomType
        }
        if let goodsName = obj["goodsName"].string {
            goodDetail.goodsName = goodsName
        }
        if let interficeType = obj["interficeType"].string {
            goodDetail.interficeType = interficeType
        }
        if let salePrice = obj["salePrice"].int {
            goodDetail.salePrice = salePrice
        }

        return goodDetail
    }
    
}
