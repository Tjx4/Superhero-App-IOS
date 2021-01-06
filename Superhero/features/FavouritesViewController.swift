
import UIKit

class FavouritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var cvFavSuperheroes: UICollectionView!
    var superheroes: [SuperheroTable]?
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cvFavSuperheroes.register(FavouritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavouritesCollectionViewCell.identifier)
        cvFavSuperheroes.delegate = self as UICollectionViewDelegate
        cvFavSuperheroes.dataSource = self as UICollectionViewDataSource
        //cvFavSuperheroes.layout
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

extension FavouritesViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        segueToScreen(segueIdentifier: "viewFavHeroSegue")
    }
}

extension FavouritesViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superheroes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let favouritesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCollectionViewCell.identifier, for: indexPath) as! FavouritesCollectionViewCell
        
        let superhero: SuperheroTable? = superheroes?[indexPath.row]
        favouritesCollectionViewCell.config(superhero: superhero)
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = hexStringToUIColor(hex:"#e1e1e5")
        favouritesCollectionViewCell.selectedBackgroundView = bgColorView
        
        return favouritesCollectionViewCell
    }
    
}


/*
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
*/
