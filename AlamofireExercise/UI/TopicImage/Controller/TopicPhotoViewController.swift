//
//  TopicPhotoViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit
import Kingfisher

class TopicPhotoViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var nameTopic = ""
    var dataSources = [UrlModel]()
    var nameAuth = ""
        
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 300
        tableView.register(UINib(nibName: "TopicPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "TopicPhotoTableViewCell")
    }
    
    func setNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil)
        self.navigationItem.title = nameTopic
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }

}

//MARK: UITableViewDelegate
extension TopicPhotoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageViewController = ImageViewController()
        imageViewController.urlStringImage = dataSources[indexPath.row].urls.regular
        imageViewController.nameAuth = nameAuth
        self.navigationController?.pushViewController(imageViewController, animated: true)
    }
}

//MARK: UITableViewDataSource
extension TopicPhotoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopicPhotoTableViewCell", for: indexPath) as? TopicPhotoTableViewCell else { return TopicPhotoTableViewCell()
        }
        PhotoManager.shared.loadImage(url: dataSources[indexPath.row].urls.regular, image: cell.topicImageView)
        cell.nameAuthLabel.text = nameAuth
        return cell
    }
    
}
