//
//  PhotoViewFront.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /18/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class PhotoViewFront: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        containerView.addSubview(photo)
        containerView.addSubview(userName)
        containerView.addSubview(likes)
        addSubview(containerView)
        createShadow()
    }
    
    // MARK: Constraints for subview
    private var didSetupConstraints = false
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            autoPinEdgesToSuperviewEdges()
            
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
}

extension UIView {
    
    func  createShadow() {
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
    
}
