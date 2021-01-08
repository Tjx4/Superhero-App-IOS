//
//  RatingViewController.swift
//  Superhero
//
//  Created by Tshepo Mahlaula on 2021/01/03.
//

import UIKit
import AARatingBar

class RatingViewController: UIViewController {

    @IBOutlet weak var niTitle: UINavigationItem!
    @IBOutlet weak var imgvHeroImage: RoundedUIImageView!
    @IBOutlet weak var rbRating: AARatingBar!
    var superhero: Superhero?
    let dbHelper = DbHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        niTitle.title = superhero?.name

        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
        rbRating.value = CGFloat(superhero!.rating)
        
        dbHelper.connect()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        superhero?.rating = Float(rbRating.value)
        dbHelper.superheroTable.update(superhero: superhero?.toFavSuperhero() ?? FavSuperhero()) //Todo Fix
    }


}
