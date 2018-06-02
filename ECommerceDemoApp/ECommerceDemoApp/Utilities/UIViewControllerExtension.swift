//
//  UIViewControllerExtension.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func subCategoryViewController() -> ProductSubCategoryVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: ProductSubCategoryVC.self)) as! ProductSubCategoryVC
    }
    
    static func productListViewController() -> ProductListVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: ProductListVC.self)) as! ProductListVC
    }
    
    static func productDetailViewController() -> ProductDetailsVC {
        return UIStoryboard.main().instantiateViewController(withIdentifier: String(describing: ProductDetailsVC.self)) as! ProductDetailsVC
    }
}
