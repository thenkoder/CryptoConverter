//
//  GradientView.swift
//  Converter HW_3
//
//  Created by Другов Родион on 17.11.2019.
//  Copyright © 2019 Другов Родион. All rights reserved.
//

import UIKit

class GradientView: UIView {
    let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
    }
}
