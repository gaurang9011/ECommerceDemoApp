//
//  ProductDetailImageCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailImageCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // This func is used to set the product images based on the category
    func setProductImage(category: String) {
        if category.lowercased() == "electronics" {
            imgProduct.image = CategoryImages.electronics
        } else {
            imgProduct.image = CategoryImages.menswear
        }
    }
}
