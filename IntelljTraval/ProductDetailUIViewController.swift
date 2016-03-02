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
    var goodDetail: GoodDetail? {
        didSet {
            if let goodName = self.goodDetail?.goodsName {
                self.productNameLabel.text = goodName
                self.productNameLabel.sizeToFit()
            }
            
            if let price = self.goodDetail?.salePrice {
                self.productPriceLabel.text = "¥\(price)"
            }
            
            if let intro = self.goodDetail?.intro {
                self.productIntroLabel.text = intro
                self.productIntroLabel.sizeToFit()
            }
            
            if self.imageContainer != nil {
                imageContainer?.imageNames = goodDetail?.imageName
            }
            
            self.indicator.stopAnimating()
        }
    }
    var imageContainer: UIBillboardViewController?
    
    let goodDetailService = GoodDetailService()
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productIntroLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置indicator
//        self.indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        self.indicator.frame = self.view.frame
//        self.indicator.layer.backgroundColor = (UIColor(white: 0.0, alpha: 1.0) as! CGColor)
//        self.indicator.center = self.view.center
        
        //获取数据
        if let productId = self.good?.id {
            goodDetailService.getGoodDetail (
                productId:  String(productId),
                type:       "",
                dataServiceResponse: DataServiceResponse(success: getGoodsDetailSuccess, error: getGoodsError)
            )
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "productImageContainer" {
            self.imageContainer = (segue.destinationViewController as! UIBillboardViewController)
        }
    }
    
    //*****************************************************************
    // MARK : 获取产品详细成功回调
    //*****************************************************************
    func getGoodsDetailSuccess(genericReturnObject: GenericReturnObject<VoidCommonObject, GoodDetail>) -> Void {
        self.goodDetail = genericReturnObject.obj
    }
    
    //*****************************************************************
    // MARK : 获取产品列表失败回调
    //*****************************************************************
    func getGoodsError(error: NSError) -> Void {
        
    }
}