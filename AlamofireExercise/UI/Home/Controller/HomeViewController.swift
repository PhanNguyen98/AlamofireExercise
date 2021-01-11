//
//  HomeViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 04/01/2021.
//

import UIKit
import Kingfisher
import SVProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataListPhotos = [ImageModel]()
    var dataListTopic = [TopicModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDataTableView()
        setDataListTopic()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicTableViewCell")
    }
    
    func setDataTableView() {
        PhotoManager.shared.getListImage() { result in
            switch result {
            case .success(let listImage):
                guard let list = listImage else { return }
                self.dataListPhotos = list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setDataListTopic() {
        PhotoManager.shared.getListTopic() { result in
            switch result {
            case .success(let list):
                guard let listTopic = list else { return }
                self.dataListTopic = listTopic
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let cell = cell as? HomeTableViewCell else { return }
            cell.setSearchBar(delegate: self)
        case 1:
            guard let cell = cell as? TopicTableViewCell else { return }
            cell.setCollectionViewDelegateDataSource(dataSourceDelegate: self)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = dataListPhotos[indexPath.row].urls.regular
            self.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Explore"
        case 2:
            return "New"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        default:
            return dataListPhotos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
                return HomeTableViewCell()
            }
            tableView.rowHeight = 450
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath) as? TopicTableViewCell else {
                return TopicTableViewCell()
            }
            tableView.rowHeight = 200
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {
                return PhotoTableViewCell()
            }
            tableView.rowHeight = 400
            PhotoManager.shared.loadImage(url: dataListPhotos[indexPath.row].urls.regular, image: cell.contentImageView)
            return cell
        }
    }

}

extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: true, completion: nil)
        searchBar.endEditing(true)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topicPhotoViewController = TopicPhotoViewController()
        topicPhotoViewController.dataSources = self.dataListTopic[indexPath.row].list
        topicPhotoViewController.nameTopic = self.dataListTopic[indexPath.row].title
        self.navigationController?.pushViewController(topicPhotoViewController, animated: true)
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
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

