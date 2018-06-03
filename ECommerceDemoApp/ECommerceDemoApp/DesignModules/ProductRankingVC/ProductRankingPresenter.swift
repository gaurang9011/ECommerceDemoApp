//
//  ProductRankingPresenter.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductRankingPresenterDelegate: class {
    
    func fetchRankingProdcuts()
    func updateCurrentRootCategory(currentCategory: ProductCategory)
    func receivedRankingProducts(list: [String: [CategoryProduct]])
}

class ProductRankingPresenter: ProductRankingPresenterDelegate {
    
    weak var viewControllerDelegate: ProductRankingDelegate!
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
