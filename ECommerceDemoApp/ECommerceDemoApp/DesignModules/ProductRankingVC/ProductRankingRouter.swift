//
//  ProductRankingRouter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductRankingRouter {

    weak var viewControllerObject: ProductRankingVC!
    
    func showProductDetails(product: CategoryProduct) {
        
        let productDetailViewController = UIViewController.productDetailViewController()
        productDetailViewController.product = product
        viewControllerObject.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
