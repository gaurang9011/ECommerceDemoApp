//
//  ProductCategoryVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductCategoryVC: CustomViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeController()
        setupUI()
    }
    
    // MARK: - Custom methods
    
    /// This method is used to setup views and subviews when view loads.
    func setupUI() {
        
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - initializeController
    func initializeController() {
        self.title = ApplicationTitles.categoryTitle
    }
}

// MARK: - UITableViewDataSource
extension ProductCategoryVC: UITableViewDataSource {

    // show main category as sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //categories.count
    }
    
    // show sub category as section rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //let category = categoryAtIndex(index: section)
        //return category.childCategories.count
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.subCategoryCell, for: indexPath)
        
        // set sub category details
        //let subcategory = subCategoryAtIndexPath(indexPath: indexPath)
        //cell.setProductSubCategoryDetails(subCategory: subcategory)
        
        return cell
    }
}

// MARK: - UITableViewDataSource
extension ProductCategoryVC: UITableViewDelegate {
    
}
