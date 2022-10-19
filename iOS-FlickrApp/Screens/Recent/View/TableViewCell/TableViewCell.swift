//
//  TableViewCell.swift
//  iOS-FlickrApp
//
//  Created by Eray on 17.10.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var profilePhoto: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var photoNew: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
