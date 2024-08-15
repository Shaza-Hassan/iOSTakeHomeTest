//
//  Color.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    @nonobjc class var titleBlue : UIColor {
        return UIColor(red: 23/255, green: 3/255, blue: 65/255, alpha: 1.0)
    }
    
    @nonobjc class var blueGrayBorder : UIColor {
        return UIColor(red: 195/255, green: 192/255, blue: 209/255, alpha: 1.0)
    }
    
    @nonobjc class var subtitleBlue : UIColor {
        return UIColor(red: 66/255, green: 90/255, blue: 96/255, alpha: 1.0)
    }
    
    @nonobjc class var lightGrayBorder : UIColor {
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    }
    
    @nonobjc class var aliveColor : UIColor {
        return UIColor(red: 232/255, green: 243/255, blue: 248/255, alpha: 1.0)
    }
    
    @nonobjc class var deadColor : UIColor {
        return UIColor(red: 251/255, green: 231/255, blue: 235/255, alpha: 1.0)
    }
    
    @nonobjc class var statusColor : UIColor {
        return UIColor(red: 97/255, green: 203/255, blue: 244/255, alpha: 1.0)
    }
    
    @nonobjc class var spicesColor: UIColor {
        return UIColor(red: 79/255, green: 72/255, blue: 114/255, alpha: 1.0)
    }
    
    @nonobjc class var genderColor : UIColor {
        return UIColor(red: 130/255, green: 124/255, blue: 156/255, alpha: 1.0)
    }
}

extension Color {
    static let titleBlue = Color(UIColor.titleBlue)
    static let blueGrayBorder = Color(UIColor.blueGrayBorder)
    static let subtitleBlue = Color(UIColor.subtitleBlue)
    static let lightGrayBorder = Color(UIColor.lightGrayBorder)
    static let aliveColor = Color(UIColor.aliveColor)
    static let deadColor = Color(UIColor.deadColor)
    static let statusColor = Color(UIColor.statusColor)
    static let spicesColor = Color(UIColor.spicesColor)
    static let genderColor = Color(UIColor.genderColor)
}
