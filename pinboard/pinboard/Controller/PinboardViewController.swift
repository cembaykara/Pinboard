//
//  ViewController.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit
import GenericFetcher

class PinboardViewController: UIViewController, DataFetcherDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createCollectionView()
        didRefresh()
    }
    
    //MARK: Setup CollectionView
    let yOffset :CGFloat = 60
    let layout = Layout(xSpacing: 12, ySpacing: 12.0, columnCount: 2)
    var collectionView: PinboardCollectionView!
    
    func createCollectionView() {
        collectionView = PinboardCollectionView(frame: view.frame, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.fetchDelegate = self
    }
    
    func didRefresh() {
        let fetcher = Fetcher()
        var fetchedData = [Object]()
        fetcher.fetch(with: .json, urlStr: "http://pastebin.com/raw/wgkJgazE") { (data: [Object],_ ,_) in
            data.forEach({
                fetchedData.append($0)
            })
            self.collectionView.reloadData()
            self.collectionView.fetchedData = fetchedData
            self.collectionView.refresher.endRefreshing()
        }
    }

}
