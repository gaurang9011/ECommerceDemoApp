//
//  CustomViewController.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

class CustomViewController: UIViewController {

    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setNavigationBar()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: Navigation Bar Methods
    func setNavigationBar () {
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: NavigationTheme.NavigationTitleColor, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)]
        navigationController?.navigationBar.barTintColor = NavigationTheme.NavigationBarColor
        navigationController?.navigationBar.tintColor = NavigationTheme.NavigationBarTintColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: Hide-Show NativationBar
    func hideNavigationBar(_ hidden: Bool) {
        navigationController?.navigationBar.isHidden = hidden
    }
    
    // Add back button to Nativationbar
    func addBackButtonNavBar() {
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonClicked() {
        // pop controller
        _ = navigationController?.popViewController(animated: true)
    }
}
