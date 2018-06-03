//
//  ProductRankingPresenter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK: Protocols
protocol ProductRankingPresenterDelegate: class {
    
    // This function is used to gets all the ranking products
    func fetchRankingProdcuts()
    
    // This function is used to update the category after selection
    func updateCurrentRootCategory(currentCategory: ProductCategory)
    
    // This function is used to show ranking product in the list.
    func receivedRankingProducts(list: [String: [CategoryProduct]])
}

/**
 ProductRankingPresenter:
 This class is used to get the data from the interactor on user actions and after getting data from the interactor, it sends it to the view to show it.
 */
class ProductRankingPresenter: ProductRankingPresenterDelegate {
    
    // MARK: Properties Declaration
    weak var viewControllerDelegate: ProductRankingDelegate!
    
    // An interactor object
    var interactor: ProductRankingInteractorDelegate!
    
    func fetchRankingProdcuts() {
        self.interactor.fetchRankingProdcuts()
    }
    
    func updateCurrentRootCategory(currentCategory: ProductCategory) {
        self.interactor.updateCurrentRootCategory(currentCategory: currentCategory)
    }
    
    func receivedRankingProducts(list: [String: [CategoryProduct]]) {
        self.viewControllerDelegate.displayRankingProducts(list: list)
    }
}
