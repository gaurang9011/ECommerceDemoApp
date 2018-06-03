//
//  ProductDetailsVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

typealias SelectedVariant = (color: String, size: Int?)

class ProductDetailsVC: CustomViewController  {

    @IBOutlet weak var tableView: UITableView!
    
    var product: CategoryProduct?
    var currentVariant = SelectedVariant("", nil)
    
    
    var colors: [String] {
        return product?.product.colors() ?? []
    }
    
    var sizes: [ProductVariant] {
        return product?.product.getAvailableSizeForColor(currentVariant.color) ?? []
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupUI()
        self.initializeController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let color = colors.first {
            currentVariant.color = color
            
            if let variant = sizes.first {
                currentVariant.size = variant.size
            }
            tableView.reloadData()
        }
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
        
        self.title = product?.categoryName
        self.tableView.reloadData()
    }
}

extension ProductDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailImageCell, for: indexPath) as! ProductDetailImageCell
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            cell.setProductImage(category: appDelegate.currentRootCategory?.name ?? (product?.categoryName)!)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailInfoCell, for: indexPath) as! ProductDetailInfoCell
            cell.setProductDetails(details: (product?.product)!, variant: currentVariant)
            return cell
        }
        
    }
    
    // TableView Delegate Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return CGFloat(CellHeightDetails.productImageCelllHeight)
            
        case 1:
            return UITableViewAutomaticDimension
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
