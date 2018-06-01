//
//  ProductCategory.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ProductCategory: Object, Mappable  {

    //Mark: Properties
    @objc dynamic var categoryId: Int   = 0
    @objc dynamic var name: String      = ""
    var products = List<Product>()
    var childCategoryIds = List<Int>()
    
    //Mark: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categoryId      <- map["id"]
        name            <- map["name"]
        products        <- (map["products"], ListTransform<Product>())
        
        if let categoryIds = map.JSON["child_categories"] as? [Int] {
            categoryIds.forEach({ (value) in
                childCategoryIds.append(value)
            })
        }
    }
    
    override static func primaryKey() -> String? {
        return "categoryId"
    }
    
    var childCategories = List<ProductCategory>()
    
    var hasChildCategories: Bool {
        return childCategoryIds.count>0
    }
    
    var hasParent:Bool = false
}
