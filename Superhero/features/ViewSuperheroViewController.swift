import UIKit
import SDWebImage

class ViewSuperheroViewController: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var imgvHeroImage: UIImageView!
    var superhero: Superhero?
    
    override func viewDidLoad() {
        navBar.title = superhero?.name
        
        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
}
