//
//  CustomTextField.swift
//  Newspaper
//
//  Created by Chidi Emeh on 12/21/17.
//  Copyright © 2017 Chidi Emeh. All rights reserved.
//

import UIKit

//@IBDesignable
class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //First loadin func
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetUp()
        customize()
    }
    
    //First required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetUp()
        customize()
    }
    
    //Sets up the textfield
    //to custom
    func defaultSetUp(){
        //Textfield
        layer.borderWidth = 1
        
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes:
            [NSAttributedStringKey.foregroundColor : UIColor.lightGray])
        layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
    }
    
    func customize(){
        layer.cornerRadius = 1
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1).cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 7
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
    }

}

//
//
//
////MARK: - Customization
//extension CustomTextField {
//    
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

