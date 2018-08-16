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
        addSubview(containerView)
        createShadow()
    }
    
    // MARK: Constraints for subview
    private var didSetupConstraints = false
    override func updateConstraints() {
        
        if (!didSetupConstraints) {
            
            autoPinEdgesToSuperviewEdges()
            containerView.autoPinEdgesToSuperviewEdges()
            photo.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}
