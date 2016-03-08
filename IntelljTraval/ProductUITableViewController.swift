//
//  ProductUITableViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/2/14.
//  Copyright © 2016年 yishiyao. All rights reserved.
//
import UIKit

class ProductUITableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    struct Constants {
        static let scenicId = "1"
        static let pageSize = "20"
        static let sortType = "0"
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //查询产品关键字，默认为空,会在addMore()和searchProductByKeyword()两个方法中被设置为参数
    var keyword: String = ""
    
    private var goods: [Good] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var page: Int = 1
    var footerIndicator: UIActivityIndicatorView?
    
    let goodsManager: GoodsService = GoodsService()
    let imageManager: ImageService = ImageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置navigation bar为白色解决了阴影问题，也解决了searchbar位置错误的问题
//        self.navigationController!.view.backgroundColor = UIColor(white: 1, alpha: 1)
        
        //配置刷新控制器
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("onRefresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl!.backgroundColor = HexUIColor(netHex: HexUIColor.HexUIColorItems.PrimaryGray)
        
        //配置搜索控制器
        self.tableView.tableHeaderView = configureSearchController()
        
        //打开页面之后自动刷新
        onRefresh()
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let productDetailVc: ProductDetailUIViewController = storyboard.instantiateViewControllerWithIdentifier("productDetailVc") as? ProductDetailUIViewController {
                productDetailVc.good = goods[indexPath.row]
                
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(productDetailVc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        self.keyword = searchController.searchBar.text ?? ""
        searchProductByKeyword()
    }
    
    //*****************************************************************
    // MARK : 配置SearchController
    //*****************************************************************
    func configureSearchController() -> UISearchBar {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        let searchBar = searchController.searchBar
        searchBar.frame = CGRectMake (
            self.searchController.searchBar.frame.origin.x,
            self.searchController.searchBar.frame.origin.y,
            self.searchController.searchBar.frame.size.width,
            44.0
        );
        definesPresentationContext = true
        searchBar.placeholder = "搜索商品"
        
        //设置searchbar的placeholder文字颜色为主色
//        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
//        textFieldInsideSearchBar?.backgroundColor = HexUIColor(netHex: HexUIColor.Gray)
//        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.valueForKey("placeholderLabel") as? UILabel
//        textFieldInsideSearchBarLabel?.textColor = HexUIColor(netHex: HexUIColor.DarkerPrimaryColor)
//        searchBar.barTintColor = UIColor.whiteColor()
        
        //设置searchbar颜色
//        searchBar.searchBarStyle = UISearchBarStyle.Minimal
//        let textFieldInsideSearchBar = searchBar.valueForKey("searchField") as? UITextField
//        textFieldInsideSearchBar?.backgroundColor = HexUIColor(netHex: HexUIColor.Gray)
//        textFieldInsideSearchBar?.tintColor = UIColor.whiteColor()
        searchBar.barTintColor = HexUIColor(netHex: HexUIColor.HexUIColorItems.PrimaryGray)
        
        //将searchbar上面的“Cancel”按键换成“完成”，颜色改为深绿
        let barButton = UIBarButtonItem.appearanceWhenContainedInInstancesOfClasses([UISearchBar.Type]())
        barButton.tintColor = HexUIColor(netHex: HexUIColor.HexUIColorItems.DarkerPrimaryColor)
        searchBar.setValue("完成", forKey:"_cancelButtonText")
        
        //消除uisearchbar上下的分界线
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = HexUIColor(netHex: HexUIColor.HexUIColorItems.PrimaryGray).CGColor
        return searchBar
    }
    
    //*****************************************************************
    // MARK : 获取产品列表成功回调
    //*****************************************************************
    func getGoodsSuccess(genericReturnObject: GenericReturnObject<Good, VoidCommonObject>) -> Void {
        //将刷新状态解除
        if self.refreshControl!.refreshing {
           self.refreshControl!.endRefreshing()
        }
        
        let goods = genericReturnObject.list
        self.goods = goods
    }
    
    //*****************************************************************
    // MARK : 获取更多数据成功回调
    //*****************************************************************
    func addGoods(genericReturnObject: GenericReturnObject<Good, VoidCommonObject>) -> Void {
        //将底部载入indicator解除
        if let tableRefreshing = footerIndicator?.isAnimating() {
            if tableRefreshing {
                footerIndicator?.stopAnimating()
            }
        }
        
        let goods = genericReturnObject.list
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
    
    //刷新数据，也就是展示第一页数据
    func onRefresh() {
        //开始显示刷新标志
        if (self.refreshControl?.refreshing == false) {
            self.refreshControl?.beginRefreshing()
        }
        
        //将page设置为0，以免之后载入分页数据出现错误
        page = 1
        
        //如果正在载入下一页数据，则取消请求
        
        //清理缓存
        imageManager.imageCache?.clearDiskCache()
        
        goodsManager.getGoods(
            scenicId:               Constants.scenicId,
            searchContent:          "",
            type:                   "",
            sortType:               Constants.sortType,
            page:                   String(page),
            pageSize:               Constants.pageSize,
            dataServiceResponse:    DataServiceResponse<Good, VoidCommonObject>(
                success:    getGoodsSuccess,
                error:      getGoodsError
            )
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
                scenicId:               Constants.scenicId,
                searchContent:          keyword,
                type:                   "",
                sortType:               Constants.sortType,
                page:                   String(page),
                pageSize:               Constants.pageSize,
                dataServiceResponse:    DataServiceResponse<Good, VoidCommonObject>(
                    success:    addGoods,
                    error:      getGoodsError
                )
            )
        }
    }
    
    //根据关键字查询
    func searchProductByKeyword() {
        //将page设置为0，以免之后载入分页数据出现错误
        page = 1
        
        goodsManager.getGoods(
            scenicId:               Constants.scenicId,
            searchContent:          keyword,
            type:                   "",
            sortType:               Constants.sortType,
            page:                   String(page),
            pageSize:               Constants.pageSize,
            dataServiceResponse:    DataServiceResponse<Good, VoidCommonObject>(
                success:    getGoodsSuccess,
                error:      getGoodsError
            )
        )
    }
    
    //新增tableview底部uiactivityindicator
    func createFooterIndicator() -> UIActivityIndicatorView{
        let footerIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        footerIndicator.hidesWhenStopped = true
        footerIndicator.frame = CGRectMake(0, 0, 320, 44)
        self.tableView.tableFooterView = footerIndicator
        return footerIndicator
    }
}
