//
//  TopicTableViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit
import SVProgressHUD

protocol TopicTableViewCellDelegate: class {
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, data: TopicModel, tableViewCell: UITableViewCell)
}

class TopicTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var cellDelegate: TopicTableViewCellDelegate?
    var dataSources = [TopicModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: Setup CollectionView
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TopicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopicCollectionViewCell")
    }
    
}

//MARK: UICollectionViewDelegate
extension TopicTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellDelegate?.collectionView(collectionView: collectionView, didSelectItemAt: indexPath, data: dataSources[indexPath.row], tableViewCell: self)
    }
    
}

//MARK: UICollectionViewDataSource
extension TopicTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCollectionViewCell", for: indexPath) as? TopicCollectionViewCell else {
            return TopicCollectionViewCell()
        }
        cell.nameTopicLabel.text = dataSources[indexPath.row].title
        PhotoManager.shared.loadImage(url: dataSources[indexPath.row].profile.urls.regular, image: cell.topicImageView)
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension TopicTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width - 40, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}


