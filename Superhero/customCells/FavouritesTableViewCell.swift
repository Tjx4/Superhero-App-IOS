//
//  FavouritesTableViewCell.swift
//  Superhero
//
//  Created by Tshepo Mahlaula on 2021/01/04.
//

import UIKit
import AARatingBar

class FavouritesTableViewCell: UITableViewCell {

    @IBOutlet var imgSuperhero: RoundedUIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var rbCurrentRating: AARatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "FavouritesTableViewCell", bundle: nil)
    }
    
    public func config(superhero: SuperheroTable?){
        
        lblName.text = superhero?.name
        
        imgSuperhero.sd_setImage(with: URL(string: superhero?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        rbCurrentRating.value = CGFloat(superhero?.rating ?? 0.0)
  
    }
    
}
