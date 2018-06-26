//
//  ViewController.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        createCollectionView()
    }
    
    //MARK: Setup CollectionView
    let yOffset :CGFloat = 60
    let layout = Layout(xSpacing: 12, ySpacing: 12.0, columnCount: 2)
    var collectionView: PinboardCollectionView!
    
    func createCollectionView() {
        collectionView = PinboardCollectionView(collectionViewLayout: layout)
        self.view.addSubview(collectionView)
        collectionView.setNeedsLayout()
    }
}
