//
//  GradientTextView.swift
//  AnimatableGradients
//
//  Created by Julia Nikitina on 17/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

@IBDesignable
final class GradientTextView: UIView {

    private lazy var textLayer: CATextLayer = {
        let text = CATextLayer()
        text.alignmentMode = .center
        text.font = UIFont(name: "Avenir", size: 20)
        text.frame = bounds
        layer.addSublayer(text)
        return text
    }()
    
    
    private lazy var gradient: CAGradientLayer = {
        let gr = CAGradientLayer()
        gr.frame = textLayer.frame
        gr.colors = [#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.9873046875, green: 0.8198070843, blue: 0, alpha: 1).cgColor]
        return gr
    }()
    
    @IBInspectable
    var text: String = "Hello" {
        didSet {
            updateTextLayer()
        }
    }
    
    private func updateTextLayer() {
        textLayer.string = text
       
    }

    override func awakeFromNib() {
        textLayer.addSublayer(gradient)
    }
    
    override func prepareForInterfaceBuilder() {
         textLayer.addSublayer(gradient)
    }
    
    
}
