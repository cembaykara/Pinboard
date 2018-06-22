//
//  Layout.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /186/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    
    //MARK: Properties
    private(set) var columnCount: Int
    private(set) var xSpacing: CGFloat
    private(set) var ySpacing: CGFloat
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {return 0}
        let collectionViewInsets = collectionView.contentInset
        return (collectionView.bounds.width) - (collectionViewInsets.left + collectionViewInsets.right)
    }
    
    private var columnWidth: CGFloat{
       return contentWidth / CGFloat(columnCount)
    }
    
    private var contentCellWidth: CGFloat {
        return columnWidth - xSpacing
    }
    
    private lazy var contentHeight: CGFloat = UIScreen.main.bounds.height / CGFloat(columnCount+1)
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    
    //MARK: Initializers
    init(xSpacing: CGFloat, ySpacing: CGFloat, columnCount columns: Int) {
        columnCount = columns
        self.xSpacing = xSpacing
        self.ySpacing = ySpacing
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Methods
    override func prepare() {

        guard let collectionView = collectionView, attributesCache.isEmpty == true else {return}

        let contentCellHeight = contentHeight
        
        var xOffset = [CGFloat]()
        for element in 0 ..< columnCount {
            xOffset.append( (CGFloat(element) * (columnWidth)) + xSpacing/2)
        }
        
        var yOffset = [CGFloat](repeating: 0, count: columnCount)
        
        var column = 0
        for cell in 0 ..< collectionView.numberOfItems(inSection: 0){
            
            let indexPath = IndexPath(item: cell, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            var frame = CGRect()
            
            if indexPath.item == 0 {
                frame = CGRect(x: xOffset[column], y: yOffset[column], width: contentWidth - xSpacing, height: contentCellHeight)
            }else{
                frame = CGRect(x: xOffset[column], y: yOffset[column], width: contentCellWidth, height: contentCellHeight)
                column = column < (columnCount - 1) ? (column + 1) : 0
            }
            
            attribute.frame = frame
            attributesCache.append(attribute)
            
            contentHeight = frame.maxY
            yOffset[column] = yOffset[column] + ySpacing + contentCellHeight
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in attributesCache {
            if attribute.frame.intersects(rect){
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesCache[indexPath.item]
    }
    
}
