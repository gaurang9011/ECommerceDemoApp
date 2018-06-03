//
//  StoryboardExtension.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}


extension UIColor {

    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
    static func fromString(value: String) -> UIColor {
        
        if value.lowercased() == "red" {
            return UIColor.red
        }
        
        if value.lowercased() == "green" {
            return UIColor.green
        }
        
        if value.lowercased() == "blue" {
            return UIColor.blue
        }
        
        if value.lowercased() == "white" {
            return UIColor.white
        }
        
        if value.lowercased() == "black" {
            return UIColor.black
        }
        
        if value.lowercased() == "brown" {
            return UIColor.brown
        }
        
        if value.lowercased() == "light blue" {
            return UIColor(hex: "4590B6")
        }
        
        if value.lowercased() == "yellow" {
            return UIColor.yellow
        }
        
        if value.lowercased() == "grey" {
            return UIColor.gray
        }
        
        if value.lowercased() == "silver" {
            return UIColor(hex: "FFD700")
        }
        
        if value.lowercased() == "golden" {
            return UIColor(hex: "DAA520")
        }
        return UIColor.blue
    }
}
