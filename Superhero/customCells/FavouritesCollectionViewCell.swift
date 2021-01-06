import UIKit
import AARatingBar

class FavouritesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgSuperhero: RoundedUIImageView!
    
    @IBOutlet var lblName: UILabel!
    static let identifier = "FavouritesCollectionViewCell"
    
    @IBOutlet var rbCurrentRating: AARatingBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "FavouritesCollectionViewCell", bundle: nil)
    }
    
    public func config(superhero: SuperheroTable?){
        
        lblName.text = superhero?.name
        
        imgSuperhero.sd_setImage(with: URL(string: superhero?.imageUrl ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        rbCurrentRating.value = CGFloat(superhero?.rating ?? 0.0)
  
    }
}
