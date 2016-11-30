//
//  PokemonArray.swift
//  Pokedex
//
//  Created by roux g. buciu on 2016-11-30.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import Foundation

class PokemonParser {
    
    var pokemon = [Pokemon]()

    func parsePokemonCSV() {
        
        // Force unwrapping because I am including the file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            createPokemonObject(parsedData: rows)
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func pullPokeIDFromParsedCSV(parsedCSVData: [String: String]) -> Int {
        let pokeID = Int(parsedCSVData["id"]!)!
        return pokeID
    }

    func pullNameFromParsedCSV(parsedCSVData: [String: String]) -> String {
        let pokeName = parsedCSVData["identifier"]!
        
        return pokeName
    }

    func createPokemonObject(parsedData: [[String: String]]) {
        for item in parsedData {
            
            let pokemonName: String = pullNameFromParsedCSV(parsedCSVData: item)
            let pokemonID: Int = pullPokeIDFromParsedCSV(parsedCSVData: item)
            let poke = Pokemon(name: pokemonName, pokedexID: pokemonID)
            pokemon.append(poke)
        }
        
    }
}
