
import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet var tvFavSuperheroes: UITableView!
    var superheroes: [SuperheroTable]?
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvFavSuperheroes.register(FavouritesTableViewCell.nib(), forCellReuseIdentifier: FavouritesTableViewCell.identifier)
        tvFavSuperheroes.delegate = self as UITableViewDelegate
        tvFavSuperheroes.dataSource = self as UITableViewDataSource
    
    }
    
    @IBAction func onCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "viewFavHeroSegue" :
            let viewSuperheroViewController = segue.destination as! ViewSuperheroViewController
            viewSuperheroViewController.superhero = superheroes?[selectedIndex].toSuperhero()
            
        default:
            var fdf = 0 // Todo Remove
        }
        
   }
}

extension FavouritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        segueToScreen(segueIdentifier: "viewFavHeroSegue")
    }
    
}

extension FavouritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let favouritesTableViewCell = tableView.dequeueReusableCell(withIdentifier: FavouritesTableViewCell.identifier, for: indexPath) as! FavouritesTableViewCell
        
        let superhero: SuperheroTable? = superheroes?[indexPath.row]
        favouritesTableViewCell.config(superhero: superhero)
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = hexStringToUIColor(hex:"#e1e1e5")
        favouritesTableViewCell.selectedBackgroundView = bgColorView
        
        return favouritesTableViewCell
    }
    

}
