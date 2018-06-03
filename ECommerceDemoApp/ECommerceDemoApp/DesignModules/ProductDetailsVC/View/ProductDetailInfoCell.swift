//
//  ProductDetailInfoCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailInfoCell: UITableViewCell {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblProductTax: UILabel!
    @IBOutlet weak var lblFinalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProductDetails(details: Product, variant:SelectedVariant) {
        
        self.lblProductName.text = details.name.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lblProductPrice.text = ""
        self.lblProductTax.text = ""
        self.lblFinalPrice.text = ""
        
        if let values = details.getPriceForVariant(selectedVariant: variant) {
            
            self.lblProductPrice.text = "Rs. " + values.0.string
            self.lblProductTax.text = "Tax" + " " + "Rs. " + values.1.string
            let sum = values.0.value + values.1.value
            self.lblFinalPrice.text = "Rs. " + String(sum)
        }
    }
}
