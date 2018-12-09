//
//  ViewController.swift
//  AnimatableGradients
//
//  Created by Julia Nikitina on 17/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

final class GradientViewController: UIViewController {
    @IBOutlet weak var gradientButton: GradientButton!
    private var isEmitting: Bool = false
    private var emitterLayer: CAEmitterLayer?
    private var cell: CAEmitterCell?
    private var image: UIImage = {
        guard
            let image = UIImage(named:
                "sample-886-ice-cream-cone.png")
            else { return UIImage() }
        return image
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.colors = [
            #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor,
            #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor,
        ]
        return gradientLayer
    }()
    
    @IBAction func buttonTapped(_ sender: GradientButton) {
        if isEmitting {
            deleteEmitterLayer()
        } else {
            createEmitterLayer()
            addGradientAnimation()
        }
        isEmitting = !isEmitting
    }
    
    private func deleteEmitterLayer() {
        emitterLayer?.removeFromSuperlayer()
        gradientLayer.removeFromSuperlayer()
        gradientLayer.mask = nil
        emitterLayer = nil
        cell = nil
    }
    
    private func createEmitterLayer() {
        emitterLayer = CAEmitterLayer()
        cell = CAEmitterCell()
        emitterLayer?.emitterPosition = gradientButton.center
        emitterLayer?.emitterSize = CGSize(width: 10,
                                           height: 10)
        gradientButton.layer.zPosition = 1
        emitterLayer?.zPosition = 0
        
        cell?.birthRate = 10
        cell?.lifetime = 10
        cell?.velocity = 100
        cell?.scale = 0.5
        cell?.beginTime = CACurrentMediaTime() - 1
        cell?.emissionRange = CGFloat.pi * 2
        cell?.contents = image.cgImage
        emitterLayer?.emitterCells = [cell
            ?? CAEmitterCell()]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.mask = emitterLayer
    }

    private func addGradientAnimation() {
        let anim = CABasicAnimation(
            keyPath: "colors")
        anim.fromValue = [
            #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).cgColor,
            #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor,
        ]
        anim.toValue = [
            #colorLiteral(red: 0.9873046875, green: 0.8198070843, blue: 0.4259450619, alpha: 1).cgColor,
            #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor,
        ]
        anim.duration = 3
        anim.repeatCount = .infinity
        anim.autoreverses = true
        gradientLayer.colors = [
            #colorLiteral(red: 0.9873046875, green: 0.8198070843, blue: 0.4259450619, alpha: 1).cgColor,
            #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor,
        ]
        gradientLayer.add(anim,
                          forKey: "colors")
    }
}
