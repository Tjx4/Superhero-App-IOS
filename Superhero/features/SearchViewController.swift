
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
    
    
/*
     
     let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
     print("json = \(json)")
     
        var superhero = Superhero()
        var image = Image()
        image.url = "http://appicsoftware.co.za/api/Platinum_access_backend/1/profpic.jpeg"
        superhero.image = image
        superhero.name = "My man"
        
        var superhero2 = Superhero()
        var image2 = Image()
        image2.url = "http://appicsoftware.co.za/api/Platinum_access_backend/2/profpic.jpeg"
        superhero2.image = image2
        superhero2.name = "My lady"
        
        superheroes = [superhero, superhero2]
    
*/
    @IBAction func onViewFavouritesClicked(_ sender: Any) {
        segueToScreen(segueIdentifier: "viewFavouritesSegue")
    }
    
    @IBAction func onLogoClicked(_ sender: Any) {
    }
    
    func viewSuperhero(superhero: Superhero){
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "viewHeroSegue" {
              let viewSuperheroViewController = segue.destination as! ViewSuperheroViewController
            
              viewSuperheroViewController.superhero = superheroes?[selectedIndex]
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
