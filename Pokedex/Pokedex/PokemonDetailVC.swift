//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by roux g. buciu on 2016-11-30.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var pokedekIDLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var nextEvolutionLbl: UILabel!
    @IBOutlet weak var currentEvolutionImg: UIImageView!
    @IBOutlet weak var nextEvolutionImg: UIImageView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = pokemon.name.capitalized
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
