//
//  ProductRankingVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// MARK: Protocols
protocol ProductRankingDelegate: class {
    
    // This function is used to display the ranking products.
    func displayRankingProducts(list: [String: [CategoryProduct]])
}

/**
 ProductRankingVC:
 This class is used to send the user actions to the presenter and shows whatever the presenter tells it.
 */
class ProductRankingVC: CustomViewController  {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties Declaration
    
    var products = [String: [CategoryProduct]]()
    
    // A presenter object
    var presenter: ProductRankingPresenterDelegate!
    
    // A router object
    var router: ProductRankingRouter!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeController()
        setupUI()
    }
    
    // MARK: Custom functions
    // This method is used to setup UI when view loads
    func setupUI() {
        
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // MARK: Initialize Controller
    func initializeController() {
        
        self.title = ApplicationTitles.rankingTitle
        
        let presenter = ProductRankingPresenter()
        self.presenter = presenter
        
        let interactor = ProductRankingInteractor()
        interactor.presenter = presenter
        
        self.router = ProductRankingRouter()
        
        presenter.interactor = interactor
        presenter.viewControllerDelegate = self
        router.viewControllerObject = self
        
        self.presenter.fetchRankingProdcuts()
    }
}

extension ProductRankingVC {
    
    // Used to category name at given index
    func getCategoryName(index: Int) -> String {
        return Array(products.keys)[index]
    }
    
    // User to get ranking product details at given indexPath
    func getProductDetails(at indexPath: IndexPath) -> CategoryProduct {
        let name = getCategoryName(index: indexPath.section)
        return products[name]![indexPath.row]
    }
}

// MARK: ProductRankingDelegate
extension ProductRankingVC: ProductRankingDelegate {
    
    func displayRankingProducts(list: [String: [CategoryProduct]]) {
        self.products = list
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ProductRankingVC: UITableViewDataSource, UITableViewDelegate {
    
    // TableView DataSource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products[getCategoryName(index: section)]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.subCategoryTableViewCell, for: indexPath)
        
        let productDetails = getProductDetails(at: indexPath)
        cell.setRankingProductDetails(ranking: productDetails)
        return cell
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.categoryTableViewCell)

        categoryCell?.setRankingProductCategoryName(name: getCategoryName(index: section))
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let productDetails = getProductDetails(at: indexPath)
        self.router.loadProductDetails(product: productDetails)
    }
}

