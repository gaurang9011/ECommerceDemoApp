//
//  ProductRankingRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

/**
 ProductRankingRouter:
 This class has all navigation logic for describing which screens are to be shown when.
 */
class ProductRankingRouter {

    // MARK: Properties Declaration
    weak var viewControllerObject: ProductRankingVC!
   
    // MARK: Custom functions
    
    // This function is used to show products details for the selected product.
    func loadProductDetails(product: CategoryProduct) {
        
        let productDetailViewController = UIViewController.productDetailViewController()
        productDetailViewController.product = product
        viewControllerObject.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
