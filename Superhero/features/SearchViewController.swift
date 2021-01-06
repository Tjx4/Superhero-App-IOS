
import UIKit
import Moya

class SearchViewController: UIViewController {

    @IBOutlet weak var superheroTableView: UITableView!
    @IBOutlet weak var txtSearch: SearchUITextField!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var lblNoresults: UILabel!
    let superheroProvider = MoyaProvider<SuperheroService>()
    var superheroes: [Superhero]?
    var selectedIndex: Int!
    var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
        
        superheroTableView.register(SuperheroTableViewCell.nib(), forCellReuseIdentifier: SuperheroTableViewCell.identifier)
        superheroTableView.delegate = self as! UITableViewDelegate
        superheroTableView.dataSource = self as! UITableViewDataSource
    
        self.txtSearch.delegate = self
        // handle the editingChanged event by calling (textFieldDidEditingChanged(-:))
            self.txtSearch.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidEditingChanged(_ textField: UITextField) {

        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
     
        searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text!, repeats: false)
    }

    @objc func searchForKeyword(_ timer: Timer) {
        let keywords = "\(timer.userInfo ?? "")"
        
        if keywords.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty{
            return
        }
        
        activityLoader.isHidden = false
        activityLoader.translatesAutoresizingMaskIntoConstraints = false
        activityLoader.startAnimating()
        
        
        searchForSuperHeroes(keywords: keywords)
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    func searchForSuperHeroes(keywords: String)  {
        self.lblNoresults.isHidden = true
        self.superheroes?.removeAll()
        self.superheroTableView.reloadData()
        
        superheroProvider.request(.search(keyword: keywords)) { (result) in
            
            switch result {
                case .success(let response) :
                    self.activityLoader.isHidden = true
                    
                    let searchResult = try! JSONDecoder().decode(SearchResponse.self, from: response.data)
                    self.superheroes = searchResult.results
                    self.superheroTableView.reloadData()
                    
                    if (searchResult.results?.isEmpty ?? true) {
                        self.showNoResults(keywords: keywords)
                    }
              
                case .failure(let error) :
                    self.activityLoader.isHidden = true
                    print("Error: \(error)")
                    
                    self.showNoResults(keywords: keywords)
                    
             }
        }
    }
    
    
    func showNoResults(keywords: String){
        self.lblNoresults.isHidden = false
        self.lblNoresults.text = "No heroes found that match - \(keywords)"
    }

    @IBAction func onViewFavouritesClicked(_ sender: Any) {
        segueToScreen(segueIdentifier: "viewFavouriteSuperheroesSegue")
    }
    
    @IBAction func onLogoClicked(_ sender: Any) {
    }
    
    func viewSuperhero(superhero: Superhero){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "viewHeroSegue" :
            let viewSuperheroViewController = segue.destination as! ViewSuperheroViewController
            viewSuperheroViewController.superhero = superheroes?[selectedIndex]
            
        case "viewFavouriteSuperheroesSegue" :
            let uINavigationController = segue.destination as! UINavigationController
            
            let favouritesViewController = uINavigationController.viewControllers.first as! FavouritesViewController
            
            //Todo remove
            var hero1 = SuperheroTable()
            hero1.id = superheroes?[0].id
            hero1.name = superheroes?[0].name
            hero1.intelligence = superheroes?[0].powerstats?.intelligence
            hero1.strength = superheroes?[0].powerstats?.strength
            hero1.speed = superheroes?[0].powerstats?.speed
            hero1.fullName = superheroes?[0].biography?.fullName
            hero1.alterEgos = superheroes?[0].biography?.alterEgos
            hero1.placeOfBirth = superheroes?[0].biography?.placeOfBirth
            hero1.publisher = superheroes?[0].biography?.publisher
            hero1.rating = 3.0
            hero1.imageUrl = superheroes?[0].image?.url
            
            var hero2 = SuperheroTable()
            hero2.id = superheroes?[1].id
            hero2.name = superheroes?[1].name
            hero2.intelligence = superheroes?[1].powerstats?.intelligence
            hero2.strength = superheroes?[1].powerstats?.strength
            hero2.speed = superheroes?[1].powerstats?.speed
            hero2.fullName = superheroes?[1].biography?.fullName
            hero2.alterEgos = superheroes?[1].biography?.alterEgos
            hero2.placeOfBirth = superheroes?[1].biography?.placeOfBirth
            hero2.publisher = superheroes?[1].biography?.publisher
            hero2.rating = 4.0
            hero2.imageUrl = superheroes?[1].image?.url
            
            var hero3 = SuperheroTable()
            hero3.id = superheroes?[2].id
            hero3.name = superheroes?[2].name
            hero3.intelligence = superheroes?[2].powerstats?.intelligence
            hero3.strength = superheroes?[2].powerstats?.strength
            hero3.speed = superheroes?[2].powerstats?.speed
            hero3.fullName = superheroes?[2].biography?.fullName
            hero3.alterEgos = superheroes?[2].biography?.alterEgos
            hero3.placeOfBirth = superheroes?[2].biography?.placeOfBirth
            hero3.publisher = superheroes?[2].biography?.publisher
            hero3.rating = 1.0
            hero3.imageUrl = superheroes?[2].image?.url
            
            var superheroes = [hero3, hero2, hero1, hero3, hero2, hero1, hero1, hero2,hero1, hero2, hero1, hero1, hero3, hero1]
            
            favouritesViewController.superheroes = superheroes 
            
        default:
            var fdf = 0 // Todo Remove
        }
        
   }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        segueToScreen(segueIdentifier: "viewHeroSegue")
        self.txtSearch?.resignFirstResponder()
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superheroes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let superheroTableViewCell = tableView.dequeueReusableCell(withIdentifier: SuperheroTableViewCell.identifier, for: indexPath) as! SuperheroTableViewCell
        
        let superhero: Superhero? = superheroes?[indexPath.row]
        superheroTableViewCell.config(superhero: superhero)
        
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = hexStringToUIColor(hex:"#e1e1e5")
        superheroTableViewCell.selectedBackgroundView = bgColorView
        
        return superheroTableViewCell
    }
    

}
