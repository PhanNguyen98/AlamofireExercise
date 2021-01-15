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
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setSearchController()
    }
    
    //MARK: setUI and Data
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
                    UserDefaultManager.shared.setData(text: name)
                    self.listResult = list.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let response):
                var message = ""
                for item in response.errors {
                    message += item
                }
                let alert = UIAlertController(title: "Search Image Error", message: message, preferredStyle: UIAlertController.Style.alert)
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
            self.searchController.searchBar.text = UserDefaultManager.shared.getData()[indexPath.row]
        default:
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = listResult[indexPath.row].urls.regular
            imageViewController.nameAuth = listResult[indexPath.row].user.name
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
            return UserDefaultManager.shared.getData().count
        default:
            return listResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
            cell.keySearchLabel.text = UserDefaultManager.shared.getData()[indexPath.row]
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
