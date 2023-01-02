//
//  RoundedButton.swift
//  portfolio
//
//  Created by stud-b20404 on 09/12/2022.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var shouldRoundLeftBottomCorner: Bool = true {
        didSet {
            updateMaskingCorners()
        }
    }
    
    @IBInspectable var shouldRoundLeftTopCorner: Bool = true {
        didSet {
            updateMaskingCorners()
        }
    }
    
    @IBInspectable var shouldRoundRightBottomCorner: Bool = true {
        didSet {
            updateMaskingCorners()
        }
    }
    
    @IBInspectable var shouldRoundRightTopCorner: Bool = true {
        didSet {
            updateMaskingCorners()
        }
    }
    
    private func updateMaskingCorners() {
        var maskedCorners: UInt = 0
        if shouldRoundLeftTopCorner {
            maskedCorners += CACornerMask.layerMaxXMinYCorner.rawValue
        }
        if shouldRoundRightTopCorner {
            maskedCorners += CACornerMask.layerMaxXMinYCorner.rawValue
        }
        if shouldRoundLeftTopCorner {
            maskedCorners += CACornerMask.layerMaxXMinYCorner.rawValue
        }
        if shouldRoundLeftTopCorner {
            maskedCorners += CACornerMask.layerMaxXMinYCorner.rawValue
        }
        layer.maskedCorners = CACornerMask(rawValue: maskedCorners)
    }
    
}
