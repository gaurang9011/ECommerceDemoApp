//
//  ProductCategoryPresenter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK: Protocols
protocol ProductCategoryPresenterDelegate: class {
    
    // This function used to get product categories
    func fetchProductCategories()
    
    // This function is used to update the category after selection
    func updateCurrentRootCategory(currentCategory: ProductCategory)
    
    // This function is used to show data in the list.
    func receivedProductCategories(list: [ProductCategory])
}

// MARK: ProductCategoryPresenter
/**
 ProductCategoryPresenter:
 This class is used to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it.
 */
class ProductCategoryPresenter:ProductCategoryPresenterDelegate {
    
    // MARK: Properties Declaration
    
    // A viewController delegate object
    weak var viewControllerDelegate: ProductCategoryDelegate!
    
    // An interactor object
    var interactor: ProductCategoryInteractorDelegate!
    
    // MARK: - ProductCategoryPresenterDelegate
    func fetchProductCategories() {
        self.interactor.fetchProductCategories()
    }
    
    func updateCurrentRootCategory(currentCategory: ProductCategory) {
        self.interactor.updateCurrentRootCategory(currentCategory: currentCategory)
    }
    
    func receivedProductCategories(list: [ProductCategory]) {
        self.viewControllerDelegate.displayProductCategories(list: list)
    }
}

