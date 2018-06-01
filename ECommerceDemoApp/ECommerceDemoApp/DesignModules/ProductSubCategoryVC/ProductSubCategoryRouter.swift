//
//  ProductSubCategoryRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductSubCategoryRouter {

    weak var viewControllerObject: ProductSubCategoryVC!
    
    func showProductType(category:ProductCategory) {
        
        let productListViewController = UIViewController.productListViewController()
        productListViewController.selectedCategory = category
        viewControllerObject.navigationController?.pushViewController(productListViewController, animated: true)
    }
}
