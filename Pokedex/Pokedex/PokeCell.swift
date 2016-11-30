//
//  PokeCell.swift
//  Pokedex
//
//  Created by roux g. buciu on 2016-11-30.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbnailImage.image = UIImage(named: "\(self.pokemon.pokedexID)")
        
    }
}
