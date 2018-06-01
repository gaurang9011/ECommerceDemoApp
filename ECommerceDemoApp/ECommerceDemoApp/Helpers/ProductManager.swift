//
//  ProductManager.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ProductManager {
    
    // Mark: Singelton object
    static let shared = ProductManager()
    
    private init() {}
    
    var productCategories: [ProductCategory] = []
    var rankingProducts = [String: [FeaturedProduct]]()
}

// Save Products and Category
extension ProductManager {
    
    func saveCategoryWiseProducts(products: [ProductCategory]) {
        
        let objRealm = try! Realm()
        try! objRealm.write {
            for objCategory in products {
                objRealm.add(objCategory, update: true)
            }
        }
    }
}

// Get Products and Category
extension ProductManager {
    
    func getCategoryWiseProducts() -> [ProductCategory] {
        
        let objRealm = try! Realm()
        let categoryArray = Array(objRealm.objects(ProductCategory.self))
        
        productCategories = prepareCategoryWiseProducts(list: categoryArray)
        return productCategories
    }
}

extension ProductManager {
    
    private func prepareCategoryWiseProducts(list: [ProductCategory]) -> [ProductCategory] {
        
        for category in list {
        
            for categoryId in category.childCategoryIds {
                
                let child = list.first(where: { $0.categoryId == categoryId })
                category.childCategories.append(child!)
                child?.hasParent = true
            }
        }
        let rootNodes = list.filter({ !$0.hasParent })
        return rootNodes
    }
}
