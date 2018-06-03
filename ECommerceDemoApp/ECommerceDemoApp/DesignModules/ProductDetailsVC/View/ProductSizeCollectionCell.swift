//
//  ProductSizeCollectionCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductSizeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setSize(size: Int) {
        self.sizeView.layer.borderWidth = CGFloat(0.5)
        self.sizeView.layer.borderColor = UIColor.white.cgColor
        sizeLabel.text = "\(size)"
    }
    
    func setBorder() {
        self.sizeView.layer.borderWidth = CGFloat(1)
        self.sizeView.layer.borderColor = UIColor.blue.cgColor
    }
}
