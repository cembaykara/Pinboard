//
//  Layout.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /186/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {

    override init() {
        super.init()
        self.minimumLineSpacing = 22
        self.sectionInset = UIEdgeInsetsMake(8.0, 12, 12, 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
