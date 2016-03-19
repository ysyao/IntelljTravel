//
//  CartUIViewController.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/27.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import UIKit

class CartUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var cartTableView: UITableView!
    var cartCell: CartTableViewCell?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cartCell = (self.tableView.dequeueReusableCellWithIdentifier("CartPrototypeIdentity") as! CartTableViewCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cartCell = (tableView.dequeueReusableCellWithIdentifier("CartPrototypeIdentity", forIndexPath: indexPath) as! CartTableViewCell)
        cartCell.title.sizeToFit()
        cartCell.buyTime.sizeToFit()
        return cartCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let size: CGSize = (cartCell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize))!
        let titleSize = cartCell?.title.sizeThatFits(CGSizeMake((cartCell?.title.frame.size.width)!, CGFloat(FLT_MAX)))
        let dateSize = cartCell?.buyTime.sizeThatFits(CGSizeMake((cartCell?.buyTime.frame.size.width)!, CGFloat(FLT_MAX)))
        let accountSize = cartCell?.accountLabel.sizeThatFits(CGSizeMake((cartCell?.accountLabel.frame.size.width)!, CGFloat(FLT_MAX)))
        var height = size.height + (titleSize?.height)! + (dateSize?.height)! + (accountSize?.height)!
        height = height > 90 ? height : 90
        return (height + 1)
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
