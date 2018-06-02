//
//  ProductSubCategoryVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductSubCategoryVC: CustomViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    var router: ProductSubCategoryRouter!
    var selectedCategory: ProductCategory?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        self.initializeController()
    }
    
    //Mark: Custom methods
    
    // This method is used to setup views and subviews.
    func setupUI() {
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    //initializeController
    func initializeController() {
        
        let router = ProductSubCategoryRouter()
        self.router = router
        router.viewControllerObject = self
        
        self.title = selectedCategory?.name ?? ApplicationTitles.categoryTitle
        self.tableView.reloadData()
    }
}

extension ProductSubCategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    // TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = selectedCategory, category.childCategories.count > 0 else {
            return 0
        }
        return category.childCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.subCategoryTableViewCell, for: indexPath)
        let subCategory = selectedCategory?.childCategories[indexPath.row]
        cell.setProductSubCategoryDetails(subCategory: subCategory!)
        return cell
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let productType = selectedCategory?.childCategories[indexPath.row]
        router.showProductType(category: productType!)
    }
}

