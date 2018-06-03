//
//  ProductCategoryRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

/**
 ProductCategoryRouter:
 This class has all navigation logic for describing which screens are to be shown when.
 */
class ProductCategoryRouter {
    
    // MARK: Properties Declaration
     weak var viewControllerObject: ProductCategoryVC!
    
    // MARK: Custom methods
    // This methods is used to show subcateogries for selected category
    func loadSubCategories(category: ProductCategory) {
        let subCategoryViewController = UIViewController.subCategoryViewController()
        subCategoryViewController.selectedCategory = category
        viewControllerObject.navigationController?.pushViewController(subCategoryViewController, animated: true)
    }
}
