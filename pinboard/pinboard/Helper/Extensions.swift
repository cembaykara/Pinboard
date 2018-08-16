//
//  Extensions.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /146/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

let cacheHandler = CacheHandler(withSize: 50)

extension UIImageView {
    
    /// Will set the image property to a remote image from URL String and cache it.
   func loadImage(withURL urlStr: String) {
    
        // Use this to set a generic image for non-existing photos or leave nil
        self.image = nil
    
        if let cachedImage = cacheHandler.imageCache.object(forKey: urlStr as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
    
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    cacheHandler.imageCache.setObject(downloadedImage, forKey: urlStr as NSString)
                    self.image = downloadedImage
                }
            })
        }).resume()
    }
}
