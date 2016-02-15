//
//  ProductUITableViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/14.
//  Copyright © 2016年 yishiyao. All rights reserved.
//
import UIKit

class ProductUITableViewController: UITableViewController {
    var uiRefreshControl: UIRefreshControl?
    private var goods: [Good] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var page: Int = 1
    var footerIndicator: UIActivityIndicatorView?
    
    let goodsManager: GoodsManager = GoodsManager()
    let imageManager: ImageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiRefreshControl = UIRefreshControl()
        uiRefreshControl?.addTarget(self, action: Selector("onRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = uiRefreshControl
        onRefresh()
    }
    
    //刷新数据，也就是展示第一页数据
    func onRefresh() {
        //开始显示刷新标志
        if (self.refreshControl?.refreshing == false) {
            uiRefreshControl?.beginRefreshing()
        }
        
        //将page设置为0，以免之后载入分页数据出现错误
        page = 1
        
        //如果正在载入下一页数据，则取消请求
        
        //清理缓存
        imageManager.imageCache?.clearDiskCache()
        
        //获取数据
        goodsManager.getGoods(
            scenicId        : "1",
            searchContent   : "",
            type            : "",
            sortType        : "0",
            page            : String(page),
            pageSize        : "20",
            success         : getGoodsSuccess,
            error           : getGoodsError
        )
    }
    
    //载入下一页数据
    func addMore() {
        if self.footerIndicator == nil {
           self.footerIndicator = createFooterIndicator()
        }
        
        //如果「载入更多」在之前没有被触发，则请求更多数据
        if let display = self.footerIndicator?.isAnimating() {
            if display {
                return
            }
            self.footerIndicator?.startAnimating()
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
    }
    
    //新增tableview底部uiactivityindicator
    func createFooterIndicator() -> UIActivityIndicatorView{
        let footerIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        footerIndicator.hidesWhenStopped = true
        footerIndicator.frame = CGRectMake(0, 0, 320, 44)
        self.tableView.tableFooterView = footerIndicator
        return footerIndicator
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goods.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let good: Good = goods[indexPath.row] {
            if let tableCell: ProductTableViewCell = tableView.dequeueReusableCellWithIdentifier("GoodTableCell", forIndexPath: indexPath) as? ProductTableViewCell {
                tableCell.titleLabel.text = good.goodsName
                tableCell.detailLabel.text = good.intro
                tableCell.goodImage = UIImage(named: "default-icon.png")
                
                if good.picId != nil {
                    imageManager.retrieveImageFromServerOrCache(
                        pictureId: good.picId!,
                        success: { (image, picId) in
                            if picId == good.picId {
                                tableCell.goodImage = image
                            } else {
                                tableCell.goodImage = UIImage(named: "default-icon.png")
                            }
                        },
                        error: getGoodsError
                    )
                }
                
                if ((indexPath.row == (goods.count - 2))) {
                    page += 1
                    addMore()
                }
                return tableCell
            }
        }
        
        return UITableViewCell()
    }
    
    //*****************************************************************
    // MARK : 获取产品列表成功回调
    //*****************************************************************
    func getGoodsSuccess(goods: [Good]) -> Void {
        //将刷新状态解除
        if let isControlRefreshing = uiRefreshControl?.refreshing {
            if isControlRefreshing {
                uiRefreshControl?.endRefreshing()
            }
        }

        self.goods = goods
    }
    
    //*****************************************************************
    // MARK : 获取更多数据成功回调
    //*****************************************************************
    func addGoods(goods: [Good]) -> Void {
        //将底部载入indicator解除
        if let tableRefreshing = footerIndicator?.isAnimating() {
            if tableRefreshing {
                footerIndicator?.stopAnimating()
            }
        }
        
        //当没有新数据的情况，不做任何处理返回
        if (goods.count == 0) {
            return
        }
        self.goods.appendContentsOf(goods)
    }
    
    //*****************************************************************
    // MARK : 获取产品列表失败回调
    //*****************************************************************
    func getGoodsError(error: NSError) -> Void {
        
    }

}
