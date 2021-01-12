//
//  TopicTableViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit
import SVProgressHUD

protocol TopicTableViewCellDelegate: class {
    func presentAlert(alert: UIAlertController)
    func presentTopic(data: TopicModel, tableViewCell: UITableViewCell)
}

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var cellDelegate: TopicTableViewCellDelegate?
    var dataListTopic = [TopicModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionView()
        setDataListTopic()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TopicCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TopicCollectionViewCell")
    }
    
    func setDataListTopic() {
        SVProgressHUD.show()
        PhotoManager.shared.getListTopic(page: 1) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let list):
                guard let listTopic = list else { return }
                self.dataListTopic = listTopic
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let response):
                let alert = UIAlertController(title: "Load Topic Error", message: response.message, preferredStyle: UIAlertController.Style.alert)
                self.cellDelegate?.presentAlert(alert: alert)
            }
        }
    }
    
}

extension TopicTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellDelegate?.presentTopic(data: dataListTopic[indexPath.row], tableViewCell: self)
    }
    
}

extension TopicTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataListTopic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCollectionViewCell", for: indexPath) as? TopicCollectionViewCell else {
            return TopicCollectionViewCell()
        }
        PhotoManager.shared.loadImage(url: dataListTopic[indexPath.row].profile.urls.regular, image: cell.topicImageView)
        return cell
    }
    
}

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


