import UIKit

class SuperheroTableViewCell: UITableViewCell {
    static let identifier = "SuperheroTableViewCell"
    @IBOutlet weak var imgSuperhero: RoundedUIImageView!
    @IBOutlet weak var lblSuperheroName: UILabel!
    @IBOutlet weak var imgFav: UIImageView!
    @IBOutlet weak var imgSetFav: UIImageView!
    var onFaveClicked: ((Superhero?) -> ())!
    var superhero: Superhero!
    
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
        self.superhero = superhero
        
        lblSuperheroName.text = superhero?.name
        
        imgSuperhero.sd_setImage(with: URL(string: superhero?.image?.url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        
        let isFavourite = superhero!.isFav
        
        if(isFavourite) {
            showIsFavStar()
        }
        else {
            showDefStar()
        
            imgSetFav.isUserInteractionEnabled = true
            imgSetFav.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:))))
        }
    }
  
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        tappedImage.isHidden = true
        imgFav.isHidden = false
        
       onFaveClicked(superhero)
    }
    
    func showIsFavStar(){
        imgSetFav.isHidden = true
        imgFav.isHidden = false
    }
    
    func showDefStar(){
        imgSetFav.isHidden = false
        imgFav.isHidden = true
    }
    
}
