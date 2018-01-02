//
//  CustomButton.swift
//  Newspaper
//
//  Created by Chidi Emeh on 12/21/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //Must provide this for IBDesignables
    override init(frame: CGRect) {
        super.init(frame: frame)
        cusomtimze()
        
    }
    
    //Must provide this for IBDesignables
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        cusomtimze()
    }
    
    
    func cusomtimze(){
        layer.cornerRadius = 4
        layer.shadowRadius = 5
        layer.shadowOpacity = 8
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
    }

}

//
////MARK :- Customizations
//extension CustomButton {
//    
//    @IBInspectable
//    var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//        }
//    }
//    
//    @IBInspectable
//    var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    @IBInspectable
//    var borderColor: UIColor? {
//        get {
//            if let color = layer.borderColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.borderColor = color.cgColor
//            } else {
//                layer.borderColor = nil
//            }
//        }
//    }
//    
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//    
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
//    
//}

