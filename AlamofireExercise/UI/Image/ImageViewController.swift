//
//  ImageViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit

class ImageViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var contentImageView: UIImageView!
    
    var urlStringImage = ""
    var nameAuth = ""
    
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        setUpNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func loadImage() {
        PhotoManager.shared.loadImage(url: urlStringImage, image: contentImageView)
    }
    
    func setUpNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share(sender:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(popViewController) )
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.title = nameAuth
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    @objc func share(sender: AnyObject) {
        let message = "share"
        if let link = NSURL(string: urlStringImage) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
}
