//
//  ApplicationConstants.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

struct WebServiceURL {
    
    static let serviceURL                       = "https://stark-spire-93433.herokuapp.com/json"
}

/* Application Titles */
struct ApplicationTitles {
    
    static let rankingTitle                     = "Ranking"
    static let categoryTitle                    = "Category"
    static let productTitle                     = "Products"
}

/* Alert Messages */
struct Messages {
    
    static let internetConnection               = "No internet connection available."
    static let ResponseSuccess                  = "Product fetched successfully."
    static let ResponseFailure                  = "Some error occured. Please try again."
    static let noDataAvailable                  = "No data available. Please try again."
}

/* Cell Identifiers */
struct TableViewCellIdentifiers {
    
    static let categoryTableViewCell             = "categoryTableViewCell"
    static let subCategoryTableViewCell          = "subCategoryTableViewCell"
    static let productListTableViewCell          = "productListTableViewCell"
    static let productDetailInfoCell             = "productDetailInfoCell"
    static let productDetailImageCell            = "productDetailImageCell"
}

/* Controller Identifiers */
struct ControllerIdentifiers {
    static let subCategoryVC                    = "SubCategoryViewController"
}

/* Set Cell Size */
struct CellHeightDetails {
    static let cellHeight                       = 80.0
    static let productImageCelllHeight          = 190.0
    static let productColorCelllHeight          = 80.0
    static let productSizeCelllHeight           = 80.0
}


struct CategoryImages {
    static let electronics: UIImage             = #imageLiteral(resourceName: "electronics")
    static let menswear: UIImage                =  #imageLiteral(resourceName: "menswear")
}


let keyCategories                               = "categories"
let keyCategoryId                               = "categoryId"
let keyMostOrderedProducts                      = "Most OrdeRed Products"
let keyMostViewedProducts                       = "Most Viewed Products"
let keyMostSharedProducts                       = "Most Shared Products"
let keyRankingName                              = "ranking"
let keyRankings                                 = "rankings"
let keyProducts                                 = "products"
