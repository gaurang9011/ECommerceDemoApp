//
//  ProductListRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductListRouter {

    weak var viewControllerObject: ProductListVC!
    
    func setProductDetails(product: CategoryProduct) {
        
        let productDetailViewController = UIViewController.productDetailViewController()
        productDetailViewController.product = product
        viewControllerObject.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

