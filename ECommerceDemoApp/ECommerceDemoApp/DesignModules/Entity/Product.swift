//
//  Products.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Product: Object, Mappable {

    //Mark: Properties
    @objc dynamic var productId: Int        = 0
    @objc dynamic var name: String          = ""
    @objc dynamic var dateAdded: Date       = Date()
    @objc dynamic var tax: ProductTax?
    var variants = List<ProductVariant>()
    
    // Mark: Mappable
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        productId   <- map["id"]
        name        <- map["name"]
        dateAdded   <- map["date_added"]
        tax         <- map["tax"]
        variants    <- (map["variants"], ListTransform<ProductVariant>())
    }
    
    override static func primaryKey() -> String? {
        
        return "productId"
    }
}

extension Product {
    
    //Get Color
    func colors() -> [String] {
        return Set(variants.map {$0.color}).sorted()
    }
    
    //Get Sizes
    func sizes() -> [Int] {
        return Set((variants.map { $0.size }).filter { $0 > 0 }).sorted()
    }
    
    //Get sizes for selected color
    func getAvailableSizeForColor(_ color: String) -> [ProductVariant] {
        guard sizes().count > 0 else {
            return []
        }
        return Array(variants).filter( {$0.color == color} )
    }
    
    
    func getPriceForVariant(selectedVariant: (color: String, size: Int?)) -> ((value: Double, string: String), (value: Double, string: String))? {
        
        guard Array(variants).count > 0 else {
            return nil
        }
        
        let productVariants = Array(variants)
        
        let color = selectedVariant.color
        let size = selectedVariant.size
        
        let varFound = productVariants.first { (variant) -> Bool in
        
            if let sizeValue = size {
                return (variant.color == color) && (variant.size == sizeValue)
            }
            return variant.color == color
        }
        
        if let variant = varFound {
            
            let price = (variant.price, String(format: "%.f", variant.price))
            let additionalTax = getAdditionalTax(variant: variant)
            return (price, additionalTax)
        }
        return nil
    }
    
    func getAdditionalTax(variant: ProductVariant) -> (value: Double, string: String) {
        
        let taxValue = (variant.price * (tax?.value)!) / 100.0
        return (taxValue, String(format: "%.f", taxValue))
    }
}

struct CategoryProduct {
    
    var categoryId: Int
    var categoryName: String
    var product: Product
}
