//
//  PinboardCollectionView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /266/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

protocol CollectionViewDataFetcherDelegate: class {
    func didRefresh()
}

import UIKit

class PinboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var fetchedData = [Object]()
    weak var fetchDelegate: CollectionViewDataFetcherDelegate?
    
    let refresher: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.attributedTitle = NSAttributedString(string: "Refreshing")
        controller.addTarget(self, action: #selector(willFetch), for: .valueChanged)
        return controller
    }()

    private func setupProperties() {
        allowsMultipleSelection = false
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsetsMake(6.0, 0.0, 12.0, 0.0)
        register(PhotoViewCell.self, forCellWithReuseIdentifier: "photoCell")
        backgroundColor = .clear
        addSubview(refresher)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupProperties()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Asks the delegate to refresh
    @objc func willFetch(){
        fetchDelegate?.didRefresh()
    }
    
    //MARK: Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoViewCell
        let userData = fetchedData[indexPath.row]
        cell.centerPoint = cell.center
        
        let frontView = cell.sides.frontView as! PhotoViewFront
        let backView = cell.sides.backView  as! PhotoViewBack
        
        
            frontView.photo.loadImage(withURL: userData.coverPhoto)

            backView.photo.loadImage(withURL: userData.photo(.large))
            backView.userName.text = userData.userName
            backView.likes.text = "Likes: " + userData.userLikes
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoViewCell
        collectionView.bringSubview(toFront: cell)
        cell.flipState.flip()
    }
    
}
