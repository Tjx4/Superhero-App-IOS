//
//  FavouritesTableViewCell.swift
//  Superhero
//
//  Created by Tshepo Mahlaula on 2021/01/04.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet weak var rbCurrentRating: AARatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
