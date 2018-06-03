//
//  ProductRankingInteractor.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/3/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK: Protocols
protocol ProductRankingInteractorDelegate {
    
    // This function is used to gets all the ranking products
    func fetchRankingProdcuts()
    
    // This function is used to update the category after selection
    func updateCurrentRootCategory(currentCategory: ProductCategory)
}

/**
 ProductRankingPresenter:
This class has business logic of an app. It is used to make API calls to fetch the data from the source.
 */
class ProductRankingInteractor {
    
    // MARK: Properties Declaration
    weak var presenter: ProductRankingPresenterDelegate!
}

// MARK: ProductRankingInteractorDelegate
extension ProductRankingInteractor: ProductRankingInteractorDelegate {
 
    func fetchRankingProdcuts() {
        
        readDataFromDatabase()
        
        if ProductManager.shared.rankingProducts.keys.count == 0 {
            NetworkManager.shared.showIndicator()
        }
    
        NetworkManager.shared.request(WebServiceURL.serviceURL, success: { (data) in
            
            guard let result = data as? ResponseData else { return }
            
            // get rankings products
            if let rankingsArray = result[keyRankings] as? ResponseArray {
                
                // Save ranking products to database
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
    
    // This method is used to gets data from database
    func readDataFromDatabase() {
        
        let rankingProducts = ProductManager.shared.getRankingProductList()
        self.presenter.receivedRankingProducts(list: rankingProducts)
    }
}
