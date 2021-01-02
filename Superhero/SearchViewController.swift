
import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func onLogoTouchUpside(_ sender: Any) {
        segueToScreen(segueIdentifier: "viewHeroSegue")
    }

    func viewSuperhero(superhero: Superhero){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "viewHeroSegue" {
              let viewSuperheroViewController = segue.destination as! ViewSuperheroViewController
            
            var superhero = Superhero()
            var image = Image()
            image.url = "http://appicsoftware.co.za/api/Platinum_access_backend/1/profpic.jpeg"
            superhero.image = image
            superhero.name = "My man"
            
            viewSuperheroViewController.superhero = superhero
          }
      }
    
    
}

