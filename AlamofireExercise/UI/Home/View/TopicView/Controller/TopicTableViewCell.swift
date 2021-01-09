//
//  TopicTableViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit
import Kingfisher

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setCollectionViewDelegateDataSource(dataSourceDelegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.reloadData()
    }
    
    func setCollectionView() {
        collectionView.register(UINib(nibName: "TopicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopicCollectionViewCell")
    }
    
}

