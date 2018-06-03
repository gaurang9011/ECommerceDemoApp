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
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProductImage(category: String) {
        imgProduct.image = (category.lowercased() == "") ? CategoryImages.electronics : CategoryImages.menswear
    }
}
