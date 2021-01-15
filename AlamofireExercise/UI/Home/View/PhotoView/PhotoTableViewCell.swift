//
//  HomeTableViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 06/01/2021.
//

import UIKit
import SVProgressHUD
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var contentImageView: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
    }
    
}

