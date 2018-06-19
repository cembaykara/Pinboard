//
//  Layout.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /186/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    
    
    private(set) var columnCount :Int
    
    private var contentWidth : CGFloat {
        guard let collectionView = collectionView else {return 0}
        let collectionViewInsets = collectionView.contentInset
        return (collectionView.bounds.width / CGFloat(columnCount)) - (collectionViewInsets.left + collectionViewInsets.right)
    }
    
    private var contentHeight: CGFloat {
        return UIScreen.main.bounds.height / CGFloat(columnCount+1)
    }
    
    var contentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    var firstContentSize: CGSize {
        guard let collectionView = collectionView else {return CGSize.zero}
        let collectionViewInsets = collectionView.contentInset
        return CGSize(width: collectionView.bounds.width - (collectionViewInsets.left + collectionViewInsets.right), height: UIScreen.main.bounds.height / 3)
    }
    
    init(columnCount columns: Int) {
        columnCount = columns
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
