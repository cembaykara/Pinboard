//
//  PhotoView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit
import PureLayout

class PhotoViewCell: UICollectionViewCell {

   private let cardHeight : CGFloat = 210
   private let cardWidth : CGFloat = 130
    
    let containerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = UIColor.cellBackgroundColor.white
        return view
    }()
    
    let photo : UIImageView = {
       let view = UIImageView()
        view.contentMode = UIViewContentMode.scaleAspectFit
        return view
    }()
    
    let userName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customGray.darkGray
        label.autoSetDimension(.height, toSize: 16)
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.autoSetDimension(.height, toSize: cardHeight)
        photo.autoSetDimension(.height, toSize: UIScreen.main.bounds.width/2.3)
        
        containerView.addSubview(photo)
        containerView.addSubview(userName)
        
        self.addSubview(containerView)
        
        createShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints for subview
    var didSetupConstraints = false
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            containerView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            photo.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            
            userName.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
            userName.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            userName.autoPinEdge(.top, to: .bottom, of: photo, withOffset: 12.0)
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func  createShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
    
}
