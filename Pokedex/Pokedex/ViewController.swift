//
//  ViewController.swift
//  Pokedex
//
//  Created by roux g. buciu on 2016-11-29.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonData = PokemonParser()
    var musicPlayer: AVAudioPlayer!
    
    // Search Bar Variables
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        pokemonData.parsePokemonCSV()
        initAudio()
        
    
    }
    
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    
    
    // Collection View Protocols
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemonData.pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemonData.pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemonData.pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    
    // Search Bar Protocols
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemon = pokemonData.pokemon.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    

}

