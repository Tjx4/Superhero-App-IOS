//
//  FavouritesCollectionViewCell.swift
//  Superhero
//
//  Created by Tshepo Mahlaula on 2021/01/06.
//

import UIKit

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FavouritesCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "FavouritesCollectionViewCell", bundle: nil)
    }
    
    public func config(superhero: SuperheroTable?){
        
       // lblName.text = superhero?.name
        
      //  imgSuperhero.sd_setImage(with: URL(string: superhero?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
      //  rbCurrentRating.value = CGFloat(superhero?.rating ?? 0.0)
  
    }
}
