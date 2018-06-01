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

protocol ProductCategoryInteractorDelegate {
    
    func fetchProductCategories()
    func updateCurrentRootCategory(currentCategory: ProductCategory)
}

class ProductCategoryInteractor {
    
    weak var presenter: ProductCategoryPresenterDelegate!
    
    func retrieveDataFromDatabase () {
        
        let productCategories = ProductManager.shared.getCategoryWiseProducts()
        self.presenter.receivedProductCategories(list: productCategories)
    }
}

extension ProductCategoryInteractor: ProductCategoryInteractorDelegate {
    
    func fetchProductCategories() {
        
         fetchAndDisplayDataFromDatabase()
        
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
                
                ProductManager.shared.saveCategoryWiseProducts(products: categories)
                self.fetchAndDisplayDataFromDatabase()
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


// MARK: - Private
extension ProductCategoryInteractor {
    
    /// This method gets data from database and show them in UI
    func fetchAndDisplayDataFromDatabase() {
        
        // get category wise products
        let productCategories = ProductManager.shared.getCategoryWiseProducts()
        
        // show data from database
        self.presenter.receivedProductCategories(list: productCategories)
    }
}
