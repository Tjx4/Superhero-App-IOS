import UIKit
import SDWebImage
import Moya

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
    let superheroProvider = MoyaProvider<SuperheroService>()
    
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
    }
    
    @IBAction func onMoreInfoClicked(_ sender: UIButton) {
        sender.isHidden = true
        cvAppearance.isHidden = false
        
        alAppearance.translatesAutoresizingMaskIntoConstraints = false
        alAppearance.startAnimating()
        
        let id = superhero?.id ?? ""
        superheroProvider.request(.apearance(id: id)) { (result) in
            
            switch result {
                case .success(let response) :
                    self.alAppearance.isHidden = true
                    
                    let appearance = try! JSONDecoder().decode(Appearance.self, from: response.data)
                    
                    //For demo purposes dynamic loading of data
                    self.lblGender.text = appearance.gender
                    self.lblHeight.text = appearance.height?[1]
                    self.lblWeight.text = appearance.weight?[1]
                    
                case .failure(let error) :
                    self.alAppearance.isHidden = true
                    print("Error: \(error)")
             }
        }
        
         
    }
}
