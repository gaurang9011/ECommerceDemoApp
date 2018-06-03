//
//  ProductRankingVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductRankingDelegate: class {
    
    func displayRankingProducts(list: [String: [CategoryProduct]])
}

class ProductRankingVC: CustomViewController  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var products = [String: [CategoryProduct]]()
    
    var presenter: ProductRankingPresenterDelegate!
    var router: ProductRankingRouter!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initializeController()
        setupUI()
    }
    
    // MARK: - Custom methods
    func setupUI() {
        
        tableView.estimatedRowHeight = 55
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - initializeController
    func initializeController() {
        
        self.title = ApplicationTitles.rankingTitle
        
        let presenter = ProductRankingPresenter()
        self.presenter = presenter
        
        let interactor = ProductRankingInteractor()
        interactor.presenter = presenter
        
        let router = ProductRankingRouter()
        presenter.interactor = interactor
        presenter.viewControllerDelegate = self
        router.viewControllerObject = self
        
        self.presenter.fetchRankingProdcuts()
    }
    
    func getCategoryName(index: Int) -> String {
        return Array(products.keys)[index]
    }
    
    func getProductDetails(at indexPath: IndexPath) -> CategoryProduct {
        let name = getCategoryName(index: indexPath.section)
        return products[name]![indexPath.row]
    }
}

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
        
        let productDetailViewController = UIViewController.productDetailViewController()
        productDetailViewController.product = productDetails
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

