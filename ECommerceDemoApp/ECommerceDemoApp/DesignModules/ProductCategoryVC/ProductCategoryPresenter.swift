//
//  ProductCategoryPresenter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductCategoryPresenterDelegate: class {
    
    func fetchProductCategories()
    func updateCurrentRootCategory(currentCategory: ProductCategory)
    func receivedProductCategories(list: [ProductCategory])
}

class ProductCategoryPresenter:ProductCategoryPresenterDelegate {
    
    weak var viewControllerDelegate: ProductCategoryDelegate!
    var interactor: ProductCategoryInteractorDelegate!
    
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

