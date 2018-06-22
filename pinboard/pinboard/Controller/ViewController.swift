//
//  ViewController.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit
import GenericFetcher

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createCollectionView()
        willFetch()
    }
    
    //MARK: Setup CollectionView
    lazy var refresher: UIRefreshControl={
        let controller = UIRefreshControl()
        controller.attributedTitle = NSAttributedString(string: "Refreshing")
        controller.addTarget(self, action: #selector(willFetch), for: .valueChanged)
        return controller
    }()
    
    @objc func willFetch(){
        let fetcher = Fetcher()
        fetchedData.removeAll()
        fetcher.fetch(with: .json, urlStr: "http://pastebin.com/raw/wgkJgazE") { (data: [Object],_ ,_) in
            data.forEach({
                self.fetchedData.append($0)
            })
            self.collectionView.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    let yOffset :CGFloat = 60
    let layout = Layout(xSpacing: 12, ySpacing: 12.0, columnCount: 2)
    var collectionView: UICollectionView!
    var fetchedData = [Object]()
    
    func createCollectionView() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.autoSetDimension(.height, toSize: view.frame.height - yOffset)
        collectionView.contentInset = UIEdgeInsetsMake(6.0, 0, 0, 0)
        collectionView.register(PhotoViewCell.self, forCellWithReuseIdentifier: "photoCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.addSubview(refresher)
        self.view.addSubview(collectionView)
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

    // Constraints for subviews
    var didSetupConstraints = false
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            collectionView.autoPinEdge(toSuperviewEdge: .top, withInset: yOffset)
            collectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
            collectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}
