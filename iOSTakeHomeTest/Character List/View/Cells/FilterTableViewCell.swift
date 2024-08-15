//
//  FilterTableViewCell.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 13/08/2024.
//

import UIKit
import SwiftUI

class FilterTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView?
    var selectedFilter: FilterStatus? = nil
    var delegate: OnFilterSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "filterCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        // Configure Flow Layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .zero
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionView?.collectionViewLayout = flowLayout
        
        // Apply Inset if Needed
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterStatus.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath)
        let filter = FilterStatus.allCases[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration{
            FilterCell(filter: filter, isSelected: filter == selectedFilter)
        }.margins(.horizontal, 2)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = FilterStatus.allCases[indexPath.row]
        if selectedFilter == filter {
            selectedFilter = nil
        }else {
            selectedFilter = filter
        }
        delegate?.onFilterSelected(filter: selectedFilter)
        collectionView.reloadData()
    }
}

protocol OnFilterSelectedDelegate {
    func onFilterSelected(filter: FilterStatus?)
}
