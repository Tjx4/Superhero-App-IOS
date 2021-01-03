import UIKit
import SDWebImage

class ViewSuperheroViewController: UIViewController {
    
    @IBOutlet weak var loadingContainer: UIView!
    @IBOutlet weak var alAppearance: UIActivityIndicatorView!
    @IBOutlet weak var txtSuperhero: UILabel!
    @IBOutlet weak var txtRealName: UILabel!
    @IBOutlet weak var txtPublisher: UILabel!
    
    @IBOutlet weak var lblInteligence: UILabel!
    @IBOutlet weak var lblStrength: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblAlterEgo: UILabel!
    @IBOutlet weak var lblPlaceOfBirth: UILabel!
    @IBOutlet weak var lblApperance: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var cvAppearance: CardView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var imgvHeroImage: UIImageView!
    var superhero: Superhero?
    
    override func viewDidLoad() {
        txtSuperhero.text = superhero?.name
        
        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    @IBAction func onMoreInfoClicked(_ sender: UIButton) {
        sender.isHidden = true
        cvAppearance.isHidden = false
        
        alAppearance.translatesAutoresizingMaskIntoConstraints = false
        alAppearance.startAnimating()
        
        
        //loadingContainer
    }
}
