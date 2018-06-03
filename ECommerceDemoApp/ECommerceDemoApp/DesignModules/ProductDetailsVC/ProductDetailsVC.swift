//
//  ProductDetailsVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/1/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

// Identiry selected variant
typealias SelectedVariant = (color: String, size: Int?)

// Product Details Options
enum ProductDetailOption: Int {
    
    case image = 0,
    color,
    size,
    info
}


/**
 ProductCategoryRouter:
 This class is used to send the user actions to the presenter and shows whatever the presenter tells it.
 */
class ProductDetailsVC: CustomViewController  {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties Declaration
    
    // Used to hold currents product info
    var product: CategoryProduct?
    
    // Used to store creent variant's information
    var currentVariant = SelectedVariant("", nil)
    
    // Used to store colors available for product
    var colors: [String] {
        return product?.product.colors() ?? []
    }
    
    // Used to store sizes available for the seletced variant
    var sizes: [ProductVariant] {
        return product?.product.getAvailableSizeForColor(currentVariant.color) ?? []
    }
    
    // MARK: View LifeCycle
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
        
    // MARK: Custom functions
    
    // This method is used to setup UI when view loads
    func setupUI() {
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        addBackButtonNavBar()
    }
    
    // MARK: Initialize Controller
    func initializeController() {
        
        self.title = product?.product.name
        self.tableView.reloadData()
    }
}

// MARK: UITableView Methods
extension ProductDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    // TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
            // Product Image Cell
            case ProductDetailOption.image.rawValue:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailImageCell, for: indexPath) as! ProductDetailImageCell
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                cell.setProductImage(category: appDelegate.currentRootCategory?.name ?? (product?.categoryName)!)
                return cell
            
            // Product Color Cell
            case ProductDetailOption.color.rawValue:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailColorCell, for: indexPath) as! ProductDetailColorCell
            
                cell.setProductColors(colors: colors, selected: self.currentVariant.color)
                cell.colorCellDelegate = self
                return cell
            
            // Product Size Cell
            case ProductDetailOption.size.rawValue:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailSizeCell, for: indexPath) as! ProductDetailSizeCell
            
                cell.setProducSizes(sizes: sizes, selected: currentVariant.size)
                cell.sizeCellDelegate = self
                return cell
            
            // Product Info Cell
            case ProductDetailOption.info.rawValue:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.productDetailInfoCell, for: indexPath) as! ProductDetailInfoCell
                cell.setProductDetails(details: (product?.product)!, variant: currentVariant)
                return cell
        
            default:
                return UITableViewCell()
        }
        
    }
    
    // TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case ProductDetailOption.image.rawValue:
            return CGFloat(CellHeightDetails.productImageCelllHeight)
            
        case ProductDetailOption.color.rawValue:
            return CGFloat(CellHeightDetails.productColorCelllHeight)
            
        case ProductDetailOption.size.rawValue:
            return CGFloat(CellHeightDetails.productSizeCelllHeight)
            
        case ProductDetailOption.info.rawValue:
            return UITableViewAutomaticDimension
            
        default:
            return 0
        }
    }
}

// MARK: ProductDetailColorCellDelegate
extension ProductDetailsVC: ProductDetailColorCellDelegate {
    
    func selectedColor(color: String) {
        
        self.currentVariant.color = color
        if let variant = self.sizes.first {
            self.currentVariant.size = variant.size
        } else {
            self.currentVariant.size = nil
        }
        self.tableView.reloadData()
    }
}

// MARK: ProductDetailSizeCellDelegate
extension ProductDetailsVC: ProductDetailSizeCellDelegate {
    
    func selectedSize(size: Int) {
        self.currentVariant.size = size
        self.tableView.reloadData()
    }
}
