//
//  CacheHandler.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /146/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import Foundation

class CacheHandler {
    let imageCache = NSCache<NSString, AnyObject>()
    
    init(withSize countLimit: Int) {
        imageCache.countLimit = countLimit
    }
}
