//
//  PinboardCollectionView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /266/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

import GenericFetcher

class PinboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var fetchedData = [Object]()
    
    lazy var refresher: UIRefreshControl={
        let controller = UIRefreshControl()
        controller.attributedTitle = NSAttributedString(string: "Refreshing")
        controller.addTarget(self, action: #selector(willFetch), for: .valueChanged)
        return controller
    }()
    
    init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.autoSetDimension(.height, toSize: 1)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsetsMake(6.0, 0.0, 12.0, 0.0)
        self.register(PhotoViewCell.self, forCellWithReuseIdentifier: "photoCell")
        self.backgroundColor = .clear
        self.addSubview(refresher)
        willFetch()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func willFetch(){
        let fetcher = Fetcher()
        fetchedData.removeAll()
        fetcher.fetch(with: .json, urlStr: "http://pastebin.com/raw/wgkJgazE") { (data: [Object],_ ,_) in
            data.forEach({
                self.fetchedData.append($0)
            })
            self.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
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
    
    var didSetupConstraints = false
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            self.autoPinEdgesToSuperviewEdges()
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
}
