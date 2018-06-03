//
//  ProductSubCategoryRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

/**
 ProductSubCategoryRouter:
 This class has all navigation logic for describing which screens are to be shown when.
 */
class ProductSubCategoryRouter {

    // MARK: Properties Declaration
    weak var viewControllerObject: ProductSubCategoryVC!
    
    // MARK: Custom methods
    
    // This function is used to show products for the selected sub category
    func showProductType(category:ProductCategory) {
        
        let productListViewController = UIViewController.productListViewController()
        productListViewController.selectedCategory = category
        viewControllerObject.navigationController?.pushViewController(productListViewController, animated: true)
    }
}
