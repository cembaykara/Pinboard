//
//  PhotoViewBack.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /158/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit

class PhotoViewBack: UIView {
    
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
        view.autoSetDimensions(to: CGSize(width: 120, height: 120))
        view.layer.cornerRadius = 120 / 2
        view.contentMode = UIViewContentMode.scaleAspectFit
        view.layer.masksToBounds = true
        view.clipsToBounds = true
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
            
            photo.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
            photo.autoAlignAxis(toSuperviewAxis: .vertical)
            
            userName.autoAlignAxis(toSuperviewAxis: .vertical)
            userName.autoPinEdge(.top, to: .bottom, of: photo, withOffset: 8.0)
            
            likes.autoAlignAxis(toSuperviewAxis: .vertical)
            likes.autoPinEdge(.top, to: .bottom, of: userName)
            
            didSetupConstraints = true
        }
        super.updateConstraints()
    }

}

extension CGSize {
    
    static func /(size: CGSize, number: CGFloat) -> CGSize{
        var newSize = CGSize()
        newSize.height = size.height / number
        newSize.width = size.width / number
        return newSize
    }
}
