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
    
    func setProductDetails(product: Product) {
        textLabel?.text = self.removeWhiteSpacesAndNewlines(string: product.name)
    }
    
    func setRankingProductCategoryName(name: String) {
        textLabel?.text = self.removeWhiteSpacesAndNewlines(string: name)
    }
    
    func setRankingProductDetails(ranking: CategoryProduct) {
        
        textLabel?.text = self.removeWhiteSpacesAndNewlines(string: ranking.product.name)
        detailTextLabel?.text = self.removeWhiteSpacesAndNewlines(string: ranking.categoryName)
    }
    
    func removeWhiteSpacesAndNewlines (string: String) -> String {
        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
