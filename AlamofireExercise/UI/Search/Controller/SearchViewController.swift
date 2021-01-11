//
//  SearchViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 04/01/2021.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var listResult = [ImageModel]()
    var listKeySearch = [String]()
    var listResultForKey = [String]()
    var active = false
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        settableView()
        setSearchController()
    }
    
    //MARK: setUI
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search photos"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["Photos", "Collections", "Users"]
        searchController.searchBar.delegate = self
    }
    
    func settableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
    }

    func searchImage(name: String) {
        PhotoManager.shared.searchImage(name: name) { result in
            switch result {
            case .success(let listImage):
                if let list = listImage {
                    self.listResult = list.results
                    self.listKeySearch.append(name)
                    self.listResultForKey.append(list.results[0].urls.regular)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if active == false {
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = listResultForKey[indexPath.row]
            self.navigationController?.pushViewController(imageViewController, animated: true)
        } else {
            let imageViewController = ImageViewController()
            imageViewController.urlStringImage = listResult[indexPath.row].urls.regular
            self.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
    
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if active == false {
            return "Recent"
        } else {
            return "Result"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if active == false {
            return listKeySearch.count
        } else {
            return listResult.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if active == false {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return SearchTableViewCell() }
            cell.keySearchLabel.text = listKeySearch[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as? PhotoTableViewCell else { return PhotoTableViewCell() }
            tableView.rowHeight = 250
            PhotoManager.shared.loadImage(url: listResult[indexPath.row].urls.regular, image: cell.contentImageView)
            return cell
        }
    }
    
}

//MARK: UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

//MARK: UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let keySearch = searchBar.text {
            self.active = true
            self.searchImage(name: keySearch)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.active = false
        self.tableView.rowHeight = 30
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
