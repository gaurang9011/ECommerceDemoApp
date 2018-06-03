//
//  ProductCategoryVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK: Protocols
protocol ProductCategoryDelegate: class {

    // This function is used to display the product categories.
    func displayProductCategories(list: [ProductCategory])
}

/**
 ProductCategoryVC:
 This class is used to send the user actions to the presenter and shows whatever the presenter tells it.
 */
class ProductCategoryVC: CustomViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties Declaration
    
    // Array that holds category values
    var categories : [ProductCategory] = []
    
    // A router object
    var router: ProductCategoryRouter!
    
    // A presenter object
    var presenter: ProductCategoryPresenterDelegate!
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeController()
        setupUI()
    }
    
    // MARK: Custom methods
    // This method is used to setup UI when view loads
    func setupUI() {
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // MARK: Initialize Controller
    func initializeController() {
        self.title = ApplicationTitles.categoryTitle
        
        let presenter = ProductCategoryPresenter()
        self.presenter = presenter
        
        let interactor = ProductCategoryInteractor()
        interactor.presenter = presenter
        
        self.router = ProductCategoryRouter()
        
        presenter.interactor = interactor
        presenter.viewControllerDelegate = self
        router.viewControllerObject = self
        
        self.presenter.fetchProductCategories()
    }
    
    //This method used to get categories at given index
    func getCategoryAtIndex(index: Int) -> ProductCategory {
        return self.categories[index]
    }
    
    //This method used to get categories at given index
    func getChildCategoryAtIndexPath(indexPath: IndexPath ) -> ProductCategory {
        let category = getCategoryAtIndex(index: indexPath.section)
        return category.childCategories[indexPath.row]
    }
}

// MARK: ProductCategoryDelegate
extension ProductCategoryVC: ProductCategoryDelegate {
    
    func displayProductCategories(list: [ProductCategory]) {
        self.categories = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableView Methods
extension ProductCategoryVC: UITableViewDataSource, UITableViewDelegate {

    // TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let category = getCategoryAtIndex(index: section)
        return category.childCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.subCategoryTableViewCell, for: indexPath)
        let subcategory = getChildCategoryAtIndexPath(indexPath: indexPath)
        cell.setProductSubCategoryDetails(subCategory: subcategory)
        return cell
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.categoryTableViewCell)
        let category = getCategoryAtIndex(index: section)
        categoryCell?.setProductCategoryDetails(category: category)
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let category = getCategoryAtIndex(index: indexPath.section)
        self.presenter.updateCurrentRootCategory(currentCategory: category)
        
        let subcategory = getChildCategoryAtIndexPath(indexPath: indexPath)
        self.router.loadSubCategories(category: subcategory)
    }
}
