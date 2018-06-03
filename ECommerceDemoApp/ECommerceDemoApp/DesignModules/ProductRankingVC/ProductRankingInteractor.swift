//
//  ProductRankingInteractor.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductRankingInteractorDelegate {
    
    func fetchRankingProdcuts()
    func updateCurrentRootCategory(currentCategory: ProductCategory)
}

class ProductRankingInteractor {
    
    weak var presenter: ProductRankingPresenterDelegate!
}

extension ProductRankingInteractor: ProductRankingInteractorDelegate {
 
    func fetchRankingProdcuts() {
        
        readDataFromDatabase()
        
        if ProductManager.shared.rankingProducts.keys.count == 0 {
            NetworkManager.shared.showIndicator()
        }
    
        NetworkManager.shared.request(WebServiceURL.serviceURL, success: { (data) in
            
            guard let result = data as? ResponseData else { return }
            
            if let rankingsArray = result[keyRankings] as? ResponseArray {
                ProductManager.shared.saveRankingProducts(list: rankingsArray)
                self.readDataFromDatabase()
            }
            
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    func updateCurrentRootCategory(currentCategory: ProductCategory) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentRootCategory = currentCategory
    }
}

extension ProductRankingInteractor {
    
    func readDataFromDatabase() {
        
        let rankingProducts = ProductManager.shared.getRankingProductList()
        self.presenter.receivedRankingProducts(list: rankingProducts)
    }
}
