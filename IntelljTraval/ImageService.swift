//
//  ImageManager.swift
//  IntelljTraval
//
//  Created by 易诗尧 on 16/1/31.
//  Copyright © 2016年 yishiyao. All rights reserved.
//

import Foundation
import Alamofire
import Kingfisher

class ImageService: DataService {
    struct DataManagerConfig {
        static let MAX_DISK_CACHE: UInt = 50 * 1024 * 1024
        static let MAX_CACHE_PERIOD_IN_SECOND: NSTimeInterval = 60 * 60 * 24 * 3
        static let DEAFULT_IMAGE_WIDTH: CGFloat = 60
        static let DEAFULT_IMAGE_HEIGHT: CGFloat = 45
    }
    
    var imageCache: ImageCache? {
        didSet {
            self.imageCache!.maxDiskCacheSize = DataManagerConfig.MAX_DISK_CACHE
            self.imageCache!.maxCachePeriodInSecond = DataManagerConfig.MAX_CACHE_PERIOD_IN_SECOND
        }
    }
    
    override init() {
        super.init()
        self.imageCache = KingfisherManager.sharedManager.cache
    }
    
    
    // ***********************************
    // MARK : 通过图片id从服务器下载图片
    // ***********************************
    func retrieveImageFromServerOrCache(pictureId picId: Int, success: (image: UIImage, picId: Int) -> Void, error: (error: NSError) -> Void) {
        let url = Constants.IntelljTravalURL.IT_PICTURE_URL + "\(picId)"
        
        //查看要下载的图片是否已经被缓存，如果已经被缓存直接用现成的
        if let imageCached = self.imageCache!.retrieveImageInDiskCacheForKey(url) {
             success(image: imageCached, picId: picId)
        } else {
            print(url)
            //在图片没有缓存的情况下下载
            Alamofire.request(.GET, url).validate().responseData {
                responseData in
//                print(responseData.result.value)
//                print(responseData.result.isSuccess)
                
                if responseData.result.isSuccess {
                    if let data = responseData.result.value {
                        let image: UIImage = UIImage(data: data)!
                        
                        self.imageCache!.storeImage(image, forKey: url, toDisk: true, completionHandler: { () -> () in
                            if let imageCached = self.imageCache!.retrieveImageInDiskCacheForKey(url) {
                                success(image: imageCached, picId: picId)
                            }
                        })
                    }
                } else {
                    error(error: responseData.result.error!)
                }
            }
        }
    }
    
    // ***********************************
    // MARK : 通过图片id从服务器下载图片
    // ***********************************
    func retrieveImageFromServerOrCache(pictureId picId: Int, imageView: UIImageView) {
        let url = Constants.IntelljTravalURL.IT_PICTURE_URL + "\(picId)"
        
        //查看要下载的图片是否已经被缓存，如果已经被缓存直接用现成的
        if let imageCached = self.imageCache!.retrieveImageInDiskCacheForKey(url) {
            imageView.image = imageCached
        } else {
            print(url)
            //在图片没有缓存的情况下下载
            Alamofire.request(.GET, url).validate().responseData {
                responseData in
                if responseData.result.isSuccess {
                    if let data = responseData.result.value {
                        let image: UIImage = UIImage(data: data)!
                        
                        self.imageCache!.storeImage(image, forKey: url, toDisk: true, completionHandler: { () -> () in
                            if let imageCached = self.imageCache!.retrieveImageInDiskCacheForKey(url) {
                                imageView.image = imageCached
                            }
                        })
                    }
                } else {
                    print(responseData.result.error)
                }
            }
        }
    }
    
    
}
