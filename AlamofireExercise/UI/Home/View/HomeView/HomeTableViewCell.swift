//
//  HomeTableViewCell.swift
//  AlamofireExercise
//
//  Created by Phan Nguyen on 06/01/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setSearchBar(delegate: UISearchBarDelegate) {
        self.searchBar.delegate = delegate
    }
    
}
