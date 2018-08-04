//
//  PhotoView.swift
//  pinboard
//
//  Created by Baris Cem Baykara on /116/18.
//  Copyright © 2018 Baris Cem Baykara. All rights reserved.
//

import UIKit
import PureLayout

protocol Flipable: class {
    var flipState: FlipState {get set}
    var sides: FVSides {get set}
}

struct FVSides {
    var frontView: UIView
    var backView: UIView
}

enum FlipState {
    case front
    case back
    
    mutating func flip() {
        switch self {
        case .front:
            return self = .back
        case .back:
            return self = .front
        }
    }
    
}

extension Flipable where Self: UIView{
    
    var currentView: UIView {
        switch flipState {
        case .front:
            return sides.frontView
        case .back:
            return sides.backView
        }
    }
    
    func flipView() {
        animationFlip()
        print("Switched to \(flipState)")
        switch flipState {
        case .front:
            addSubview(sides.frontView)
            sides.frontView.isHidden = false
            sides.backView.isHidden = true
        case .back:
            addSubview(sides.backView)
            sides.frontView.isHidden = true
            sides.backView.isHidden = false
        }
    }
    
}

class FlipableView: UIView, Flipable {
    
    var flipState: FlipState = .front {
        didSet {
            flipView()
        }
    }
    
    var sides = FVSides(frontView: UIView(), backView: UIView()) {
        didSet {
            addSubview(sides.frontView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, sides: FVSides) {
        self.sides = sides
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FlipableCollectionViewCell: UICollectionViewCell, Flipable {
    
    var flipState: FlipState = .front {
        didSet {
            flipView()
        }
    }
    
    var sides = FVSides(frontView: UIView(), backView: UIView()) {
        didSet {
           addSubview(sides.frontView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, sides: FVSides) {
        self.sides = sides
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Flipable where Self: UIView {
    
    func focusIn(){
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .curveEaseOut,
                          animations: {
                            self.transform = CGAffineTransform.identity.scaledBy(x: 1.65, y: 1.65)
                            self.center = CGPoint(x: (self.superview?.bounds.midX)!, y: (self.superview?.bounds.midY)!)
        })
    }
    
    func focusOut(){
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .curveEaseOut,
                          animations: {
                            self.transform = CGAffineTransform.identity
        })
    }
    
    func animationFlip() {
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .transitionFlipFromLeft,
                          animations: {
                        
        })
    }
    
}

