
import UIKit
import Moya

class SearchViewController: UIViewController {

    @IBOutlet weak var superheroTableView: UITableView!
    @IBOutlet weak var txtSearch: SearchUITextField!
    
    var superheroes: [Superhero]?
    var selectedIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        superheroTableView.register(SuperheroTableViewCell.nib(), forCellReuseIdentifier: SuperheroTableViewCell.identifier)
        superheroTableView.delegate = self as! UITableViewDelegate
        superheroTableView.dataSource = self as! UITableViewDataSource
        
        txtSearch.delegate = self
    }

    @IBAction func onEditChanged(_ sender: Any) {
        if (sender as! SearchUITextField).text?.count ?? 0 < 4 {
           return
       }
        
      
        
        //Moya
    }
    
    
    @IBAction func onTextChangedEnd(_ sender: SearchUITextField) {
        /*
         if sender.text?.count ?? 0 < 1 {
            return
        }
        
        */
        
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
    }
    
    @IBAction func onViewFavouritesClicked(_ sender: Any) {
        segueToScreen(segueIdentifier: "viewFavouritesSegue")
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
            
        return superheroTableViewCell
    }

}
