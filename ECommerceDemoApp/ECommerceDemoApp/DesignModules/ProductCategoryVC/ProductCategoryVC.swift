//
//  ProductCategoryVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductCategoryDelegate: class {

    func displayProductCategories(list: [ProductCategory])
}

class ProductCategoryVC: CustomViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    //categories
    var categories : [ProductCategory] = []
    var router: ProductCategoryRouter!
    var presenter: ProductCategoryPresenterDelegate!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initializeController()
        setupUI()
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

extension ProductCategoryVC: ProductCategoryDelegate {
    
    func displayProductCategories(list: [ProductCategory]) {
        self.categories = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.subCategoryCell, for: indexPath)
        let subcategory = getChildCategoryAtIndexPath(indexPath: indexPath)
        cell.setProductSubCategoryDetails(subCategory: subcategory)
        return cell
    }
}

//Mark: - UITableViewDelegate
extension ProductCategoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.categoryCell)
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
