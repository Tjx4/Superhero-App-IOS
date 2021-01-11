import UIKit
import Moya

class SearchViewController: UIViewController {

    @IBOutlet weak var superheroTableView: UITableView!
    @IBOutlet weak var txtSearch: SearchUITextField!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var lblNoresults: UILabel!
    let superheroProvider = MoyaProvider<SuperheroService>()
    var superheroes: [Superhero]?
    var selectedHero: Superhero!
    var selectedIndex: Int!
    var searchTimer: Timer?
    let dbHelper = DbHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityLoader.isHidden = true
        
        superheroTableView.register(SuperheroTableViewCell.nib(), forCellReuseIdentifier: SuperheroTableViewCell.identifier)
        superheroTableView.delegate = self as! UITableViewDelegate
        superheroTableView.dataSource = self as! UITableViewDataSource
    
        self.txtSearch.delegate = self
        self.txtSearch.addTarget(self, action: #selector(textFieldDidEditingChanged(_:)), for: .editingChanged)
        
        dbHelper.connect()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if superheroes?.isEmpty ?? false || superheroes == nil{
            return
        }
        
        superheroTableView.reloadData()
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    
    func viewSuperHero(superhero: Superhero){
        selectedHero = superhero
        segueToScreen(segueIdentifier: "viewHeroSegue")
        self.txtSearch?.resignFirstResponder()
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
        self.lblNoresults.text = "no_heroes".localizeWithFormat(arguments: keywords)
    }

    @IBAction func onViewFavouritesClicked(_ sender: Any) {
        segueToScreen(segueIdentifier: "viewFavouriteSuperheroesSegue")
    }
    
    @IBAction func onLogoClicked(_ sender: Any) {
        
    }
    
    func addHeroToFavourites(superhero: Superhero?) {
        if superhero == nil {
            return
        }
        
        dbHelper.superheroTable.insert(superhero: superhero!.toFavSuperhero())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "viewHeroSegue" :
            let viewSuperheroViewController = segue.destination as! ViewSuperheroViewController
            viewSuperheroViewController.superhero = selectedHero
            
        case "viewFavouriteSuperheroesSegue" :
            let uINavigationController = segue.destination as! UINavigationController
            let favouritesViewController = uINavigationController.viewControllers.first as! FavouritesViewController
            favouritesViewController.searchViewController = self
            
        default:
            print("Unknown segue")
        }
        
   }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        let superhero = superheroes?[selectedIndex]
        
        if superhero != nil {
            self.viewSuperHero(superhero: superhero!)
        }
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
        
        var superhero: Superhero? = superheroes?[indexPath.row]
        superhero!.isFav = self.dbHelper.superheroTable.isExist(heroId: Int64(superhero!.id ?? "0") ?? 0)
        
        if superhero!.isFav {
            let faveHero = self.dbHelper.superheroTable.getFavHero(heroId: Int64(superhero?.id ?? "0") ?? 0)
            superheroes?[indexPath.row].rating = faveHero?.rating ?? 0.0
        }
        
        superheroTableViewCell.config(superhero: superhero)
        superheroTableViewCell.onFaveClicked = self.addHeroToFavourites
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = hexStringToUIColor(hex:"#e1e1e5")
        superheroTableViewCell.selectedBackgroundView = bgColorView
        
        return superheroTableViewCell
    }
    
}
