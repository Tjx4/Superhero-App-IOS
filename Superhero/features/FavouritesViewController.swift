
import UIKit

class FavouritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var cvFavSuperheroes: UICollectionView!
    var superheroes: [SuperheroTable]?
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cvFavSuperheroes?.contentInsetAdjustmentBehavior = .always
        cvFavSuperheroes.register(FavouritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavouritesCollectionViewCell.identifier)
        cvFavSuperheroes.delegate = self as UICollectionViewDelegate
        cvFavSuperheroes.dataSource = self as UICollectionViewDataSource
    }
    
    @IBAction func onCloseButtonClicked(_ sender: Any) {

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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = 2
        let inset: CGFloat = 10
        let minimumLineSpacing: CGFloat = 10
        let minimumInteritemSpacing: CGFloat = 10
        let collectionViewWidth = collectionView.bounds.size.width
        
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
       
        let itemWidth = ((collectionViewWidth - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        let itemHeight = CGFloat(230.0)
        
        
        let favouritesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCollectionViewCell.identifier, for: indexPath) as! FavouritesCollectionViewCell
        
        // favouritesCollectionViewCell.frame = CGSize(width: itemWidth, height: itemHeight)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
