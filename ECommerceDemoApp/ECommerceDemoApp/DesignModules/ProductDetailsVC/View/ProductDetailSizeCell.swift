//
//  ProductDetailSizeCell.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 6/2/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailSizeCellDelegate {
    func selectedSize(size: Int)
}

class ProductDetailSizeCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productSizes = [ProductVariant]()
    var sizeCellDelegate: ProductDetailSizeCellDelegate!
    var selectedSize: Int?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setProducSizes(sizes: [ProductVariant], selected: Int?) {
        self.productSizes = sizes
        self.selectedSize = selected
        collectionView.reloadData()
    }
}

extension ProductDetailSizeCell : UICollectionViewDataSource, UICollectionViewDelegate {

    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productSizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableViewCellIdentifiers.productSizeCollectionCell, for: indexPath) as! ProductSizeCollectionCell
        
        let variant = productSizes[indexPath.row]
        cell.setSize(size: variant.size)
        
        if selectedSize == variant.size {
            cell.setBorder()
        }
        return cell
    }
    
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedSize = productSizes[indexPath.row].size
        self.sizeCellDelegate.selectedSize(size: self.selectedSize!)
    }
}
