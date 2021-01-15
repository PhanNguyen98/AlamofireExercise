//
//  HomeViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 04/01/2021.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var dataListPhotos = [ImageModel]()
    var dataListTopic = [TopicModel]()
    var index = 1
   
    //MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        loadData()
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
    
    //MARK: SetData
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        tableView.register(UINib(nibName: "TopicTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicTableViewCell")
        tableView.sectionIndexBackgroundColor = UIColor.white
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func loadData() {
        let queue = DispatchQueue.global(qos: .userInteractive)
        SVProgressHUD.show()
        queue.async {
            let dispatchGroup = DispatchGroup()
            dispatchGroup.enter()
            self.setDataListTopic()
            dispatchGroup.leave()
            dispatchGroup.enter()
            self.setDataListPhoto(page: 1, count: 10)
            dispatchGroup.leave()
            dispatchGroup.notify(queue: .main) {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func setDataListPhoto(page: Int, count: Int) {
        PhotoManager.shared.getListPhotos(page: page, count: count) { result in
            switch result {
            case .success(let list):
                guard let listPhoto = list else { return }
                self.dataListPhotos.append(contentsOf: listPhoto)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let response):
                var message = ""
                for item in response.errors {
                    message += item
                }
                let alert = UIAlertController(title: "Load Image Error", message: message, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setDataListTopic() {
        PhotoManager.shared.getListTopic(page: 1) { result in
            switch result {
            case .success(let list):
                guard let listTopic = list else { return }
                self.dataListTopic = listTopic
            case .failure(let response):
                var message = ""
                for item in response.errors {
                    message += item
                }
                let alert = UIAlertController(title: "Load Topic Error", message: message, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            guard let cell = cell as? HomeTableViewCell else { return }
            cell.setSearchBar(delegate: self)
        case 2:
            let lastRow = dataListPhotos.count - 1
            if indexPath.row == lastRow {
                index += 1
                setDataListPhoto(page: index, count: 10)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = dataListPhotos[indexPath.row].urls.regular
            imageViewController.nameAuth = dataListPhotos[indexPath.row].user.name
            self.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 450
        case 1:
            return 200
        default:
            return 400
        }
    }
    
}

//MARK: UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return .leastNormalMagnitude
        } else {
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
                return HomeTableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicTableViewCell", for: indexPath) as? TopicTableViewCell else {
                return TopicTableViewCell()
            }
            cell.cellDelegate = self
            cell.dataSources = dataListTopic
            cell.collectionView.reloadData()
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else {
                return PhotoTableViewCell()
            }
            PhotoManager.shared.loadImage(url: dataListPhotos[indexPath.row].urls.regular, image: cell.contentImageView)
            return cell
        }
    }

}

//MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let searchViewController = SearchViewController()
        let navigationController = UINavigationController(rootViewController: searchViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        self.present(navigationController, animated: true, completion: nil)
        searchBar.endEditing(true)
    }
    
}

//MARK: TopicTableViewCellDelegate
extension HomeViewController: TopicTableViewCellDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, data: TopicModel, tableViewCell: UITableViewCell) {
        let topicPhotoViewController = TopicPhotoViewController()
        topicPhotoViewController.nameTopic = data.title
        topicPhotoViewController.dataSources = data.list
        topicPhotoViewController.nameAuth = data.profile.user.name
        self.navigationController?.pushViewController(topicPhotoViewController, animated: true)
    }
    
}

