import UIKit

class SuperheroTableViewCell: UITableViewCell {
    static let identifier = "SuperheroTableViewCell"
    @IBOutlet weak var imgSuperhero: RoundedUIImageView!
    @IBOutlet weak var lblSuperheroName: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgSetFav: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "SuperheroTableViewCell", bundle: nil)
    }
    
    public func config(superhero: Superhero?){
        
        lblSuperheroName.text = superhero?.name
        
        imgSuperhero.sd_setImage(with: URL(string: superhero?.image?.url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        //imgSetFav.isHidden = superhero.isFave
        //imgFav.isHidden = false
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgSetFav.isUserInteractionEnabled = true
        imgSetFav.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        tappedImage.isHidden = true
        imgFav.isHidden = false
        
        // Your action
    }
    
}
