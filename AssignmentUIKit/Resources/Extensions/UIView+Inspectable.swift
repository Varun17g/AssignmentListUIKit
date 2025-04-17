//
//  UIView+Inspectable.swift
//  AssignmentUIKit
//
//  Created by Varun Bhati on 16/04/25.
//

import UIKit

@IBDesignable
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
