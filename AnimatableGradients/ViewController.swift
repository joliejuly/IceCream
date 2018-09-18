//
//  ViewController.swift
//  AnimatableGradients
//
//  Created by Julia Nikitina on 17/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    var isEmitting: Bool = true
    
    @IBOutlet weak var gradientButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createEmitterLayer()
    }
    
    @IBAction func buttonTapped(_ sender: GradientButton) {
        
        
            for layer in view.layer.sublayers! {
                if let emitterLayer = layer as? CAEmitterLayer {
                    
                    if isEmitting {
                        emitterLayer.birthRate = 0
                         emitterLayer.lifetime = 0
                    } else {
                        emitterLayer.birthRate = 4
                        emitterLayer.lifetime = 10
                    }
                }
            }
        
        isEmitting = !isEmitting
        
    }
    
    private func createEmitterLayer() {
        
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.emitterPosition = gradientButton.center
        emitterLayer.emitterZPosition = -1.0
       // emitterLayer.
        
        let cell = CAEmitterCell()
        cell.birthRate = 100
        cell.lifetime = 10
        cell.velocity = 100
        cell.scale = 0.2
        
        cell.emissionRange = CGFloat.pi * 2.0
    
        cell.contents = UIImage(named: "sample-335-magic-wand.png")!.cgImage
        
        let circle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10))
        #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).setFill()
        circle.fill()
        
        let redCell = CAEmitterCell()
                redCell.birthRate = 20
                redCell.contents = circle.cgPath
                //redCell.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
                redCell.emissionRange = CGFloat.pi * 2.0
                redCell.lifetime = 10
                redCell.velocity = 5
                redCell.scale = 0.1
        
        emitterLayer.emitterCells = [cell, redCell]
        
        view.layer.addSublayer(emitterLayer)
        
        
        
//
//
//        let layer = CAEmitterLayer()
//
//        layer.frame = UIScreen.main.bounds
//
//        layer.emitterPosition = UIScreen.main.bounds.origin
//        layer.emitterShape = .circle
//        layer.emitterSize = CGSize(width: 10, height: 10)
//        layer.duration = 10
//
//        let redCell = CAEmitterCell()
//        redCell.birthRate = 20
//        redCell.contents = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10))
//        redCell.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
//        redCell.emissionRange = CGFloat.pi * 2.0
//        redCell.lifetime = 10
//        redCell.velocity = 5
//        redCell.scale = 0.1
//
//
//        let purpleCell = CAEmitterCell()
//        purpleCell.birthRate = 10
//        purpleCell.color = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor
//
//            //= UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10))
//        purpleCell.emissionRange = CGFloat.pi * 2.0
//        purpleCell.lifetime = 10
//        purpleCell.velocity = 5
//        purpleCell.scale = 0.1
//
//        layer.emitterCells = [redCell, purpleCell]
//
//        view.layer.addSublayer(layer)
//
    }

}

