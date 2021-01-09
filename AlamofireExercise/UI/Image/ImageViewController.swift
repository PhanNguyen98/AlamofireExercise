//
//  ImageViewController.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var contentImageView: UIImageView!
    
    var urlStringImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        setUpNavigation()
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    func loadImage() {
        PhotoManager.shared.loadImage(url: urlStringImage, image: contentImageView)
    }
    
    func setUpNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(share(sender:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(popViewController) )
        //self.navigationItem.
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
