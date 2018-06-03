//
//  ProductColorCollectionCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductColorCollectionCell: UICollectionViewCell {
 
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setColor(color: String) {
        colorView.backgroundColor = UIColor.fromString(value: color)
        
        self.colorView.layer.borderWidth = CGFloat(0.5)
        self.colorView.layer.borderColor = UIColor.white.cgColor
    }
    
    func setBorder() {
        
        self.colorView.layer.borderWidth = CGFloat(2)
        self.colorView.layer.borderColor = UIColor.blue.cgColor
    }
}
