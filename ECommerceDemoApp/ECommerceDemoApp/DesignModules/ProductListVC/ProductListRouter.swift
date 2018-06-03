//
//  ProductListRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

/**
 ProductListRouter:
 This class has all navigation logic for describing which screens are to be shown when.
 */
class ProductListRouter {

    // MARK: Properties Declaration
    weak var viewControllerObject: ProductListVC!
    
    // MARK: Custom methods
    
    // This function is used to show the product details for the selected product.
    func setProductDetails(product: CategoryProduct) {
        
        let productDetailViewController = UIViewController.productDetailViewController()
        productDetailViewController.product = product
        viewControllerObject.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

