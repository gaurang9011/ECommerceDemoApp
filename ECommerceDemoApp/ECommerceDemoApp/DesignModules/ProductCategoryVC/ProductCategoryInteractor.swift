//
//  ProductCategoryInteractor.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

// MARK: Protocols
protocol ProductCategoryInteractorDelegate {
    
    // This function used to get product categories
    func fetchProductCategories()
    
    // This function is used to update the category after selection
    func updateCurrentRootCategory(currentCategory: ProductCategory)
}

class ProductCategoryInteractor {
    
    // MARK: Properties Declaration
    weak var presenter: ProductCategoryPresenterDelegate!
}

// MARK: ProductCategoryInteractor
/**
 ProductCategoryInteractor:
 This class has business logic of an app. It is used to make API calls to fetch the data from the source.
 */
extension ProductCategoryInteractor: ProductCategoryInteractorDelegate {
    
    //MARK: ProductCategoryInteractorDelegate
    func fetchProductCategories() {
        
         readDataFromDatabase()
        
        if ProductManager.shared.productCategories.count == 0 {
            NetworkManager.shared.showIndicator()
        }
        
        //fetch new data from server
        NetworkManager.shared.request(WebServiceURL.serviceURL, success: { (data) in
            
            // convert to dictionary
            guard let result = data as? ResponseData else { return }
            
            // convert data into category models
            if let dataArray = result[keyCategories] as? ResponseArray {
                let categories = Mapper<ProductCategory>().mapArray(JSONObject: dataArray) ?? []
                
                //save categorywise product data to database
                ProductManager.shared.saveCategoryWiseProducts(products: categories)
                self.readDataFromDatabase()
            }
            
            if let rankingsArray = result[keyRankings] as? ResponseArray {
                //save ranking products into database
                ProductManager.shared.saveRankingProducts(list: rankingsArray)
            }
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    // updates current category value
    func updateCurrentRootCategory(currentCategory: ProductCategory) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.currentRootCategory = currentCategory
    }
}


// MARK: - ProductCategoryInteractor
extension ProductCategoryInteractor {
    
    // This method is used to gets data from database
    func readDataFromDatabase() {
        let productCategories = ProductManager.shared.getCategoryWiseProducts()
        self.presenter.receivedProductCategories(list: productCategories)
    }
}
