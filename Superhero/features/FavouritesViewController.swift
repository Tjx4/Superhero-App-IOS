
import UIKit

class FavouritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var lblNoFavourites: UILabel!
    @IBOutlet var cvFavSuperheroes: UICollectionView!
    var superheroes: [FavSuperhero]?
    var selectedIndex: Int!
    let dbHelper = DbHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cvFavSuperheroes?.contentInsetAdjustmentBehavior = .always
        cvFavSuperheroes.register(FavouritesCollectionViewCell.nib(), forCellWithReuseIdentifier: FavouritesCollectionViewCell.identifier)
        cvFavSuperheroes.delegate = self as UICollectionViewDelegate
        cvFavSuperheroes.dataSource = self as UICollectionViewDataSource
        
        dbHelper.connect()
        superheroes = dbHelper.superheroTable.getAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if (superheroes?.isEmpty ?? true)  {
            lblNoFavourites.isHidden = false
        }
        
        if superheroes?.isEmpty ?? false || superheroes == nil{
            return
        }
        
        superheroes = dbHelper.superheroTable.getAll()
        cvFavSuperheroes.reloadData()
        
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
        
        let superhero: FavSuperhero? = superheroes?[indexPath.row]
        favouritesCollectionViewCell.config(superhero: superhero)
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = hexStringToUIColor(hex:"#e1e1e5")
        favouritesCollectionViewCell.selectedBackgroundView = bgColorView
        
        return favouritesCollectionViewCell
    }
      
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = 2
        let inset: CGFloat = 10
        let minimumLineSpacing: CGFloat = 0
        let minimumInteritemSpacing: CGFloat = 0
        let collectionViewWidth = collectionView.bounds.size.width
        
        let marginsAndInsets = CGFloat(0) // inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
       
        let itemWidth = ((collectionViewWidth - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        
        let itemHeight = CGFloat(220.0)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
