//
//  ProductRankingVC.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class ProductRankingVC: CustomViewController  {
    
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
        self.title = ApplicationTitles.rankingTitle
    }
}
