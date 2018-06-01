//
//  RankingProducts.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RankingProducts: Object, Mappable {
    
    //Mark: Properties
    
    @objc dynamic var productId: Int  = 0
    @objc dynamic var order: Double = 0
    @objc dynamic var view: Double  = 0
    @objc dynamic var share: Double = 0
    
    //Mark: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        productId   <- map["id"]
        order       <- map["order_count"]
        view        <- map["view_count"]
        share       <- map["shares"]
    }

    override static func primaryKey() -> String? {
        return "productId"
    }
}
