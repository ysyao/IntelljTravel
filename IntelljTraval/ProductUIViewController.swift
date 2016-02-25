//
//  ProductUIViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/27.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class ProductUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    @IBOutlet weak var productTableView: UITableView!
    var goodUiTableViewCell: GoodUITableViewCell?
    var page: Int = 1
    
    private var goods: [Good] = [] {
        didSet {
            self.productTableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    let goodsManager: GoodsService = GoodsService()
    let imageManager: ImageService = ImageService()
    var uiRefreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        uiRefreshControl = UIRefreshControl()
        uiRefreshControl?.addTarget(self, action: Selector("onRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.productTableView.addSubview(uiRefreshControl!)
        
        onRefresh()
    }
    
    @IBAction func onRefresh() {
        self.indicator.startAnimating()
        imageManager.imageCache?.clearDiskCache()
        goodsManager.getGoods(
            scenicId        : "1",
            searchContent   : "",
            type            : "",
            sortType        : "0",
            page            : "1",
            pageSize        : "20",
            success         : getGoodsSuccess,
            error           : getGoodsError
        )
    }
    
    func addMore() {
        goodsManager.getGoods(
            scenicId        : "1",
            searchContent   : "",
            type            : "",
            sortType        : "0",
            page            : String(page),
            pageSize        : "20",
            success         : addGoods,
            error           : getGoodsError
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        goodUiTableViewCell = tableView.dequeueReusableCellWithIdentifier("GoodTableCell", forIndexPath: indexPath) as? GoodUITableViewCell
        
        if let good: Good = goods[indexPath.row] {
            if let tableCell: GoodUITableViewCell = goodUiTableViewCell {
                tableCell.titleLabel.text = good.goodsName
                tableCell.detailLabel.text = good.intro
                tableCell.goodImage = UIImage(named: "default-icon.png")
                
                imageManager.retrieveImageFromServerOrCache(
                    pictureId: good.picId!,
                    success: { (image, picId) in
                        if picId == good.picId {
                            tableCell.goodImage = image
                        }
                    },
                    error: getGoodsError
                )
            }
        }
        
        if (indexPath.row == (goods.count - 2)) {
            page += 1
            addMore()
        }
        return goodUiTableViewCell!
    }
    
    //*****************************************************************
    // MARK : 获取产品列表成功回调
    //*****************************************************************
    func getGoodsSuccess(goods: [Good]) -> Void {
        self.goods = goods
    }
    
    //*****************************************************************
    // MARK : 获取更多数据成功回调
    //*****************************************************************
    func addGoods(goods: [Good]) -> Void {
        self.goods.appendContentsOf(goods)
    }
    
    //*****************************************************************
    // MARK : 获取产品列表失败回调
    //*****************************************************************
    func getGoodsError(error: NSError) -> Void {
        
    }
}
