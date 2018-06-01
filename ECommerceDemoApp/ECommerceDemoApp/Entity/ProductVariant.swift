//
//  ProductVariant.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ProductVariant: Object, Mappable  {
    
    // Mark: Properties
    @objc dynamic var variantId: Int  = 0
    @objc dynamic var color: String   = ""
    @objc dynamic var size: Int       = 0
    @objc dynamic var price: Double   = 0
    
    // Mark: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        variantId     <- map["id"]
        color         <- map["color"]
        size          <- map["size"]
        price         <- map["price"]
    }
    
    override static func primaryKey() -> String? {
        return "variantId"
    }
}
