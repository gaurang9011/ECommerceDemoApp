//
//  ProductDetailColorCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailColorCellDelegate {
    func selectedColor(color: String)
}

class ProductDetailColorCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productColors = [String]()
    var selectedColor: String = ""
    var colorCellDelegate: ProductDetailColorCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProductColors(colors: [String], selected: String) {
        self.productColors = colors
        self.selectedColor = selected
        collectionView.reloadData()
    }
}

extension ProductDetailColorCell : UICollectionViewDataSource, UICollectionViewDelegate {

    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableViewCellIdentifiers.productColorCollectionCell, for: indexPath) as! ProductColorCollectionCell
        
        // set variant color
        let color = productColors[indexPath.row]
        cell.setColor(color: color)
        
        // if selected then set border
        if selectedColor == color { cell.setBorder() }
        return cell
    }
    
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedColor = productColors[indexPath.row]
        self.colorCellDelegate.selectedColor(color: self.selectedColor)
    }
}
