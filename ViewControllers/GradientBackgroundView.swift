//
//  GradientBackgroundView.swift
//  SneakersStore
//
//  Created by Aruzhan Adilkhasymkyzy on 29.01.2026.
//

import UIKit

final class GradientBackgroundView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    private let shapeLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }

    private func setupLayers() {
        backgroundColor = .clear
        
        gradientLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemPink.cgColor,
            UIColor.systemOrange.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        shapeLayer.lineWidth = 40
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.lineCap = .round

        gradientLayer.mask = shapeLayer
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
       
        gradientLayer.frame = bounds
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -50, y: bounds.height * 0.2))
        path.addCurve(
            to: CGPoint(x: bounds.width + 50, y: bounds.height * 0.5),
            controlPoint1: CGPoint(x: bounds.width * 0.3, y: -50),
            controlPoint2: CGPoint(x: bounds.width * 0.7, y: bounds.height + 50)
        )
        shapeLayer.path = path.cgPath
    }
}
