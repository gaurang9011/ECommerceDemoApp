//
//  ProductListVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

/**
 ProductListVC:
 This class is used to send the user actions to the presenter and shows whatever the presenter tells it.
 */
class ProductListVC: CustomViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties Declaration
    
    // A router object
    var router: ProductListRouter!
    
    // variable used to store selected product category
    var selectedCategory: ProductCategory?
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.initializeController()
    }
    
    //Mark: Custom methods
    
    // This method is used to setup UI when view loads
    func setupUI() {
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        addBackButtonNavBar()
    }
    
    // MARK: Initialize Controller
    func initializeController() {
        
        let router = ProductListRouter()
        self.router = router
        router.viewControllerObject = self
        
        self.title = selectedCategory?.name ?? ApplicationTitles.productTitle
        self.tableView.reloadData()
    }
}

// MARK: UITableView Methods
extension ProductListVC: UITableViewDataSource, UITableViewDelegate {
    
    // TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let category = selectedCategory, category.products.count > 0 else {
            return 0
        }
        return category.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productListTableViewCell, for: indexPath)
        let product = selectedCategory?.products[indexPath.row]
        cell.setProductDetails(product: product!)
        return cell
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let category = selectedCategory {
            let product = category.products[indexPath.row]
            let categoryProduct = CategoryProduct(categoryId: category.categoryId, categoryName: category.name, product: product)
            self.router.setProductDetails(product: categoryProduct)
        }
    }
}
