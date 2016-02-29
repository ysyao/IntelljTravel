//
//  ProductDetailUIViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/18.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailUIViewController: UIViewController {
    var good: Good?
    let goodDetailService = GoodDetailService()
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productIntroLabel: UILabel!
    @IBOutlet weak var introParent: UIView!
    @IBOutlet weak var rootScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let productId = self.good?.id {
            goodDetailService.getGoodDetail (
                productId:  String(productId),
                type:       "",
                dataServiceResponse: DataServiceResponse(success: getGoodsDetailSuccess, error: getGoodsError)
            )
        }
    }
    
    
    //*****************************************************************
    // MARK : 获取产品详细成功回调
    //*****************************************************************
    func getGoodsDetailSuccess(genericReturnObject: GenericReturnObject<VoidCommonObject, GoodDetail>) -> Void {
        let detail = genericReturnObject.obj
        self.productNameLabel.text = detail.goodsName
        self.productNameLabel.sizeToFit()
        if let price = detail.salePrice {
             self.productPriceLabel.text = "¥\(price)"
        }
        self.productIntroLabel.text = detail.intro
        self.productIntroLabel.sizeToFit()
    }
    
    //*****************************************************************
    // MARK : 获取产品列表失败回调
    //*****************************************************************
    func getGoodsError(error: NSError) -> Void {
        
    }
}