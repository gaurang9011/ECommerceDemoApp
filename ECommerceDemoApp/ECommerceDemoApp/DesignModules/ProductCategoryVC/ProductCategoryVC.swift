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
    
    //categories
    var categories : [ProductCategory] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeController()
        setupUI()
    }
    
    //Mark: Custom methods
    
    // This method is used to setup views and subviews when view loads.
    func setupUI() {
        
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    //initializeController
    func initializeController() {
        self.title = ApplicationTitles.categoryTitle
    }
    
    //get categories at Index
    func getCategoryAtIndex(index: Int) -> ProductCategory {
        return self.categories[index]
    }
    
    //get child categories at given index
    func getChildCategoryAtIndexPath(indexPath: IndexPath ) -> ProductCategory {
        let category = getCategoryAtIndex(index: indexPath.section)
        return category.childCategories[indexPath.row]
    }
}

//Mark: - UITableViewDataSource
extension ProductCategoryVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let category = getCategoryAtIndex(index: section)
        return category.childCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.subCategoryCell, for: indexPath)
        let subcategory = getChildCategoryAtIndexPath(indexPath: indexPath)
        cell.setProductSubCategoryDetails(subCategory: subcategory)
        return cell
    }
}

//Mark: - UITableViewDataSource
extension ProductCategoryVC: UITableViewDelegate {
    
}
