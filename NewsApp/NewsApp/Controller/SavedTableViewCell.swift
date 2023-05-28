//
//  SavedTableViewCell.swift
//  NewsApp
//
//  Created by d.chernov on 28/05/2023.
//

import UIKit

class SavedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var savedPic: UIImageView!
    @IBOutlet weak var savedLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
