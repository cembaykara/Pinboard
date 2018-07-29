//
//  PinboardCollectionView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /266/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

protocol CollectionViewDataFetcherDelegate {
    func didRefresh()
}

import UIKit

class PinboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var fetchedData = [Object]()
    var fetchDelegate: CollectionViewDataFetcherDelegate?
    
    let refresher: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.attributedTitle = NSAttributedString(string: "Refreshing")
        controller.addTarget(self, action: #selector(willFetch), for: .valueChanged)
        return controller
    }()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        contentInset = UIEdgeInsetsMake(6.0, 0.0, 12.0, 0.0)
        register(PhotoViewCell.self, forCellWithReuseIdentifier: "photoCell")
        backgroundColor = .clear
        addSubview(refresher)
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
        let user = fetchedData[indexPath.row]
        cell.userName.text = user.userName()
        cell.photo.loadImage(withURL: user.photo(.large)!)
        cell.likes.text = "Likes: " + user.userLikes()
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
    
    private var selectedIndex: IndexPath?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoViewCell
        collectionView.bringSubview(toFront: cell)
        cell.focuseIn()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoViewCell
        cell.focuseOut()
        selectedIndex = nil
    }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let selectedItem = selectedIndex else {return}
            let cell = cellForItem(at: selectedItem) as! PhotoViewCell
            deselectItem(at: selectedItem, animated: true)
            cell.focuseOut()
            selectedIndex = nil
    }
    
}

extension PhotoViewCell {
    
    func focuseIn(){
        UIView.transition(with: self,
                          duration: 0.6,
                          options: .curveEaseOut,
                          animations: {
                            self.transform = CGAffineTransform.identity.scaledBy(x: 1.65, y: 1.65)
                            self.center = CGPoint(x: (self.superview?.bounds.midX)!, y: (self.superview?.bounds.midY)!)
        })
    }
    
    func focuseOut(){
        self.layer.removeAllAnimations()
        UIView.transition(with: self,
                          duration: 0.6,
                          options: .curveEaseOut,
                          animations: {
                            self.transform = CGAffineTransform.identity
                            self.center = self.centerPoint
        })
    }
    
    func flip() {
        UIView.transition(with: self,
                          duration: 0.6,
                          options: .transitionFlipFromLeft,
                          animations: {
        })
    }
    
}
