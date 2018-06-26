//
//  PinboardCollectionView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /266/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

protocol DataFetcherDelegate {
    func didRefresh()
}

import UIKit

class PinboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var fetchedData = [Object]()
    var fetchDelegate: DataFetcherDelegate?
    
    lazy var refresher: UIRefreshControl={
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
    
}
