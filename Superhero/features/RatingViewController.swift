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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        niTitle.title = superhero?.name

        let url = superhero?.image?.url ?? ""
        imgvHeroImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
        
        rbRating.value = CGFloat(superhero?.rating ?? 0.0)
        
    }


}
