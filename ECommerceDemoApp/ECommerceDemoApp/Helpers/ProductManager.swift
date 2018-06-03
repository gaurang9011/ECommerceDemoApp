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

/*
 ProductManager:
 This class is used to manage all network calls and parsing the data.
 */
class ProductManager {
    
    // MARK: Singelton object
    static let shared = ProductManager()
    
    private init() {}
    
    // MARK: Properties
    
    // Used to store all product categories
    var productCategories: [ProductCategory] = []
    
    // User to store all ranking products
    var rankingProducts = [String: [CategoryProduct]]()
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

// Get Ranking Products
extension ProductManager {

    func getRankingProductList() -> [String: [CategoryProduct]] {
        
        let objRealm = try! Realm()
        
        // User to find Most viewed, ordered and shared data
        let orderedIds = Array(objRealm.objects(RankingProducts.self).filter("order > 0").sorted(byKeyPath: "order", ascending: false)).flatMap({ $0.productId })
        let viewedIds = Array(objRealm.objects(RankingProducts.self).filter("view > 0").sorted(byKeyPath: "view", ascending: false)).flatMap({ $0.productId })
        let sharedIds = Array(objRealm.objects(RankingProducts.self).filter("share > 0").sorted(byKeyPath: "share", ascending: false)).flatMap({ $0.productId })
        
        // Used to store Most viewed, ordered and shared products
        var orderedProducts:[CategoryProduct] = [CategoryProduct]()
        var viewedProducts:[CategoryProduct] = [CategoryProduct]()
        var sharedProducts:[CategoryProduct] = [CategoryProduct]()
        
        let categories = Array(objRealm.objects(ProductCategory.self))
        categories.filter({ $0.products.count > 0 }) .forEach { (category) in
            
            let maxOrderdProducts = category.products.filter({ orderedIds.contains($0.productId) })
                maxOrderdProducts.forEach({ (product) in
                let displayProduct = CategoryProduct(categoryId: category.categoryId, categoryName: category.name, product: product)
                orderedProducts.append(displayProduct)
            })
            
            let maxViewedProducts = category.products.filter({ viewedIds.contains($0.productId) })
                maxViewedProducts.forEach({ (product) in
                let displayProduct = CategoryProduct(categoryId: category.categoryId, categoryName: category.name, product: product)
                viewedProducts.append(displayProduct)
            })
            
            let maxSharedProducts = category.products.filter({ sharedIds.contains($0.productId) })
                maxSharedProducts.forEach({ (product) in
                let displayProduct = CategoryProduct(categoryId: category.categoryId, categoryName: category.name, product: product)
                sharedProducts.append(displayProduct)
            })
        }
        
        if orderedProducts.count > 0 {
            rankingProducts[keyOrderedProducts] = orderedProducts
        }
        if viewedProducts.count > 0 {
            rankingProducts[keyViewedProducts] = viewedProducts
        }
        if sharedProducts.count > 0 {
            rankingProducts[keySharedProducts] = sharedProducts
        }
        return rankingProducts
    }
}

extension ProductManager {
    
    func saveRankingProducts(list: [Any]) {
        
        let rankingProducts = preprareRankingProductList(list: list)
        
        let objRealm = try! Realm()
        try! objRealm.write {
            for rank in rankingProducts {
                objRealm.add(rank, update: true)
            }
        }
    }
}

// Parse Category and Product Details
extension ProductManager {
    
    // User to create tree structure of all products category wise
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
    
    // Used to create list of ranking products
    func preprareRankingProductList(list: [Any]) -> [RankingProducts] {
        
        var rankingProductList = [RankingProducts]()
        
        for item in list {
            let ranking = item as! [String: Any]
            
            let name = (ranking[keyRankingName] as! String).lowercased()
            
            let products = Mapper<RankingProducts>().mapArray(JSONObject: ranking[keyProducts]) ?? []
            for product in products {
                
                if let productFound = rankingProductList.first(where: {$0.productId == product.productId}) {
                    
                    if name == keyViewedProducts.lowercased() {
                        productFound.view = product.view
                    } else if name == keyOrderedProducts.lowercased() {
                        productFound.order = product.order
                    }
                    productFound.share = product.share
                } else {
                    rankingProductList.append(product)
                }
            }
        }
        return rankingProductList
    }
}
