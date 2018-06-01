//
//  UITableViewCellExtension.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func setProductCategoryDetails(category: ProductCategory) {
        textLabel?.text = self.removeWhiteSpacesAndNewlines(string: category.name)
    }
    
    func setProductSubCategoryDetails(subCategory: ProductCategory) {
        textLabel?.text = self.removeWhiteSpacesAndNewlines(string: subCategory.name)
    }
    
    func removeWhiteSpacesAndNewlines (string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
