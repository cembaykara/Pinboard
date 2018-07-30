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

    let containerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.backgroundColor = UIColor.cellBackgroundColor.white
        view.layer.masksToBounds = true
        return view
    }()
    
    let photo : UIImageView = {
       let view = UIImageView()
        view.contentMode = UIViewContentMode.scaleAspectFill
        return view
    }()

    let userName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customGray.darkGray
        label.autoSetDimension(.height, toSize: 18)
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    let likes : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.customGray.darkGray
        label.autoSetDimension(.height, toSize: 14)
        label.font = UIFont.systemFont(ofSize: 9)
        return label
    }()
    
    var centerPoint: CGPoint?
    var isFocusedIn = false
    var isFlipped = false {
        didSet {
            if isFlipped == true {
                photo.isHidden = true
                likes.isHidden = true
                containerView.removeConstraints(containerView.constraints)
                userName.autoCenterInSuperview()
            } else {
                didSetupConstraints = false
                containerView.removeConstraints(containerView.constraints)
                photo.isHidden = false
                likes.isHidden = false
                updateConstraints()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.addSubview(photo)
        containerView.addSubview(userName)
        containerView.addSubview(likes)
        addSubview(containerView)
        createShadow()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Constraints for subview
    var didSetupConstraints = false
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            containerView.autoPinEdgesToSuperviewEdges()
            photo.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .bottom)
            photo.autoMatch(.height, to: .width, of: containerView)
            
            userName.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
            userName.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            userName.autoPinEdge(.top, to: .bottom, of: photo, withOffset: 8.0)
            
            likes.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
            likes.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
            likes.autoPinEdge(.top, to: .bottom, of: userName)
            
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
