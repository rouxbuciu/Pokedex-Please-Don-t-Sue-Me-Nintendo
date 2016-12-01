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
