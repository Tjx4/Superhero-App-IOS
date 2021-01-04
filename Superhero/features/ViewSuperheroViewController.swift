import UIKit
import SDWebImage

class ViewSuperheroViewController: UIViewController {
    
    @IBOutlet weak var alAppearance: UIActivityIndicatorView!
    @IBOutlet weak var txtSuperhero: UILabel!
    @IBOutlet weak var txtRealName: UILabel!
    @IBOutlet weak var txtPublisher: UILabel!
    
    @IBOutlet weak var lblInteligence: UILabel!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblAlterEgo: UILabel!
    @IBOutlet weak var lblPlaceOfBirth: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    @IBOutlet weak var cvAppearance: CardView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var imgvHeroImage: UIImageView!
    var superhero: Superhero?
    
    override func viewDidLoad() {
        txtSuperhero.text = superhero?.name
        
        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
        lblInteligence.text = superhero?.powerstats?.intelligence
        lblStrength.text = superhero?.powerstats?.strength
        lblSpeed.text = superhero?.powerstats?.speed
        
        lblFullname.text = superhero?.biography?.fullName
        lblAlterEgo.text = superhero?.biography?.alterEgos
        lblPlaceOfBirth.text = superhero?.biography?.placeOfBirth
        
        lblGender.text = superhero?.appearance?.gender
        lblHeight.text = superhero?.appearance?.height?[0]
        lblWeight.text = superhero?.appearance?.weight?[0]
    }
    
    @IBAction func onMoreInfoClicked(_ sender: UIButton) {
        sender.isHidden = true
        cvAppearance.isHidden = false
        
        alAppearance.translatesAutoresizingMaskIntoConstraints = false
        alAppearance.startAnimating()
    }
}
