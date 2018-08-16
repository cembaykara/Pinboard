//
//  ViewController.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class PinboardViewController: UIViewController, CollectionViewDataFetcherDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createCollectionView()
        didRefresh()
    }
    
    //MARK: Setup CollectionView
    var collectionView: PinboardCollectionView!
    
    func createCollectionView() {
        let layout = Layout(xSpacing: 12, ySpacing: 12.0, columnCount: 2)
        collectionView = PinboardCollectionView(frame: view.frame, collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.fetchDelegate = self
    }
    
    func didRefresh() {
        
        let fetcher = Fetcher()
        var fetchedData = [Object]()
        fetcher.fetch(withString: "http://pastebin.com/raw/wgkJgazE") { (data: [Object]?, error) in
            
            guard let receivedData = data else {
                if let error = error {
                print("\(error.description)")
                }
                return
            }
            
            receivedData.forEach({
                fetchedData.append($0)
            })

            self.collectionView.fetchedData = fetchedData
            self.collectionView.reloadData()
            self.collectionView.refresher.endRefreshing()
        }
    }
    
}
