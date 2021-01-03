import UIKit
import SDWebImage

class ViewSuperheroViewController: UIViewController {
    
    @IBOutlet weak var txtSuperhero: UILabel!
    @IBOutlet weak var txtRealName: UILabel!
    @IBOutlet weak var txtPublisher: UILabel!
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var imgvHeroImage: UIImageView!
    var superhero: Superhero?
    
    override func viewDidLoad() {
        txtSuperhero.text = superhero?.name
        
        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    @IBAction func onMoreInfoClicked(_ sender: Any) {
    }
}
