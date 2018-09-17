//
//  GradientButton.swift
//  AnimatableGradients
//
//  Created by Julia Nikitina on 17/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientButton: UIButton {
    
    private enum GradientType {
        case vertical
        case horizontal
        case diagonalFromBottom
        case diagonalFromTop
        case radial
    }
    
    private lazy var gradient: CAGradientLayer = {
        let gr = CAGradientLayer()
        gr.frame = bounds
        return gr
    }()
    
    @IBInspectable
    private var firstColor: UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1) {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable
    private var secondColor: UIColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) {
        didSet {
            updateGradient()
        }
    }
    
    @IBInspectable
    private var verticalGradientType: Bool = true {
        didSet {
            if verticalGradientType {
                gradientType = .vertical
            }
        }
    }
    
   
    @IBInspectable
    private var horizontalGradientType: Bool = false {
        didSet {
            if horizontalGradientType {
                gradientType = .horizontal
            }
        }
    }
    
    @IBInspectable
    private var bottomDiagonalGradientType: Bool = false {
        didSet {
            if bottomDiagonalGradientType {
                gradientType = .diagonalFromBottom
            }
        }
    }
    
    @IBInspectable
    private var topDiagonalGradientType: Bool = false {
        didSet {
            if topDiagonalGradientType {
                gradientType = .diagonalFromTop
            }
        }
    }
    
    @IBInspectable
    private var radialGradientType: Bool = false {
        didSet {
            if radialGradientType {
                gradientType = .radial
            }
        }
    }
    
    private var gradientType: GradientType = .vertical {
        didSet {
            updateGradientType()
        }
    }
    
   
    @IBInspectable
    private var cornerRadius: Bool = false {
        didSet {
            createCornerRadius()
        }
    }
    
    @IBInspectable
    private var shouldAnimate: Bool = false {
        didSet {
            animateGradient()
        }
    }
    

    override func prepareForInterfaceBuilder() {
        setUpGradient()
        updateGradient()
    }
    
    override func awakeFromNib() {
        setUpGradient()
        updateGradient()
    }
    
    private func setUpGradient() {
        layer.addSublayer(gradient)
    }
    
    private func updateGradient() {
        gradient.colors = []
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        
        if shouldAnimate {
            animateGradient()
        }
    }
    
    private func updateGradientType() {
        switch gradientType {
            
        case .vertical: break
        case .horizontal:
            gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
            gradient.frame = bounds
            
        case .diagonalFromTop:
            gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 4, 0, 0, 1)
            gradient.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width * 3, height: bounds.height)
    
        case .diagonalFromBottom:
            gradient.transform = CATransform3DMakeRotation(CGFloat.pi / 4, 0, 0, 1)
            gradient.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width * 3, height: bounds.height)
           
        case .radial:
            gradient.type = .radial
        }
        
        let types = [verticalGradientType, horizontalGradientType, bottomDiagonalGradientType, topDiagonalGradientType, radialGradientType]
        
        for var type in types {
            type = false
        }
        
    }
    
    private func createCornerRadius() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    private func animateGradient() {
        let anim = CABasicAnimation(keyPath: "colors")
        anim.fromValue = gradient.colors
        anim.toValue = gradient.colors?.reversed()
        
        anim.duration = 3
        anim.repeatCount = .infinity
        anim.autoreverses = true
        
        gradient.colors = gradient.colors?.reversed()
        gradient.add(anim, forKey: nil)
    }

}
