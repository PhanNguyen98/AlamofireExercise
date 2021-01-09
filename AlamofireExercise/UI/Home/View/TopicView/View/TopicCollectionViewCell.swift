//
//  TopicCollectionViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 07/01/2021.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topicImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    func setUpCell() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor
    }

}
