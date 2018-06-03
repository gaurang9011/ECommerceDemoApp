//
//  ProductTax.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class ProductTax: Object, Mappable {

    // MARK: Properties
    @objc dynamic var name: String = ""
    @objc dynamic var value: Double = 0
    
    // MARK: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map:Map) {
        name    <- map["name"]
        value   <- map["value"]
    }
}
