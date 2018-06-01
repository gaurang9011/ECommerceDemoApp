//
//  ProductCategoryRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductCategoryRouter {
    
     weak var viewControllerObject: ProductCategoryVC!
    
    func loadSubCategories(category: ProductCategory) {
        let subCategoryViewController = UIViewController.subCategoryViewController()
        subCategoryViewController.selectedCategory = category
        viewControllerObject.navigationController?.pushViewController(subCategoryViewController, animated: true)
    }
}
