//
//  SearchViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 04/01/2021.
//

import UIKit
import Alamofire
import SVProgressHUD

class SearchViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var listResult = [ImageModel]()
    var active = false
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
    }
    
    //MARK: setUIandData
    func setSearchController() {
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search photos"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["Photos", "Collections", "Users"]
        searchController.searchBar.delegate = self
    }
    
    func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }

    func searchImage(name: String, page: Int) {
        SVProgressHUD.show()
        PhotoManager.shared.searchImage(name: name, page: page) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success(let listImage):
                if let list = listImage {
                    SearchManager.shared.setData(keySearch: name, data: list)
                    self.listResult = list.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let response):
                let alert = UIAlertController(title: "Search Image Error", message: response.message, preferredStyle: UIAlertController.Style.alert)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

//MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let topicPhotoViewController = TopicPhotoViewController()
            topicPhotoViewController.dataSources = SearchManager.shared.listResult[indexPath.row].results
            self.navigationController?.pushViewController(topicPhotoViewController, animated: true)
        default:
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = listResult[indexPath.row].urls.regular
            self.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 30
        default:
            return 250
        }
    }
    
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Recent"
        default:
            return "Result"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return SearchManager.shared.listKeySearch.count
        default:
            return listResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
            cell.keySearchLabel.text = SearchManager.shared.listKeySearch[indexPath.row]
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else { return PhotoTableViewCell() }
            PhotoManager.shared.loadImage(url: listResult[indexPath.row].urls.regular, image: cell.contentImageView)
            return cell
        }
    }
    
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let keySearch = searchBar.text {
            self.searchImage(name: keySearch, page: 1)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
