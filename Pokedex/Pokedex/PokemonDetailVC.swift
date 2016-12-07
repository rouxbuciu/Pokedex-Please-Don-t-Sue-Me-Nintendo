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
        
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        currentEvolutionImg.image = img
        pokedekIDLbl.text = "\(pokemon.pokedexID)"
        
        pokemon.downloadPokemonDetails {
            print("Get on my level, son!")
            //WHatever we write here will complete only when the network call is done
            
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionID == "" || Int(pokemon.nextEvolutionID)! > 800 {
            nextEvolutionLbl.text = "No Evolutions"
            nextEvolutionImg.isHidden = true
        } else {
            nextEvolutionLbl.text = pokemon.nextEvolutionText
            nextEvolutionImg.isHidden = false
            nextEvolutionImg.image = UIImage(named: pokemon.nextEvolutionID)
        }
        
    }

    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
