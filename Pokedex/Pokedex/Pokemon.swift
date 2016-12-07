//
//  Pokemon.swift
//  Pokedex
//
//  Created by roux g. buciu on 2016-11-29.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _weight: String!
    private var _height: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonURL: String!
    
    var nextEvolutionLevel: String {
        if self._nextEvolutionLevel == nil {
            self._nextEvolutionLevel = ""
        }
        
        return self._nextEvolutionLevel
    }
    
    var nextEvolutionID: String {
        if self._nextEvolutionID == nil {
            self._nextEvolutionID = ""
        }
        
        return self._nextEvolutionID
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            self._nextEvolutionName = ""
        }
        
        return self._nextEvolutionName
    }
    
    var name: String {
        if self._name == nil {
            self._name = ""
        }
        return self._name
    }
    
    var pokedexID: Int {
        
        // There will always be a PokedeID so no need to set it arbitrarily
        return self._pokedexID
    }
    
    var description: String {
        if self._description == nil {
            return ""
        }
        
        return self._description
    }
    
    var type: String {
        
        if self._type == nil {
            return ""
        }
        
        return self._type
    }
    
    var defense: String {
        
        if self._defense == nil {
            return ""
        }
        
        return self._defense
    }
    
    var weight: String {
        
        if self._weight == nil {
            return ""
        }
        
        return self._weight
    }
    
    var height: String {
        
        if self._height == nil {
            return ""
        }
        
        return self._height
        
    }
    
    var attack: String {
        
        if self._attack == nil {
            return ""
        }
        
        return self._attack
    }
    
    var nextEvolutionText: String {
        
        if self._nextEvolutionTxt == nil {
            return ""
        }
        
        return self._nextEvolutionTxt
    }
    
    
    init(name: String, pokedexID: Int) {
        
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexID!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let typesArray = dict["types"] as? [Dictionary<String, String>], typesArray.count > 0 {
                    
                    if self.type.isEmpty {
                        for dict in typesArray {
                            if let typeDescription = dict["name"] as String! {
                                if self._type == nil {
                                    self._type = "\(typeDescription.capitalized)"
                                } else {
                                    self._type! += "/\(typeDescription.capitalized)"
                                }
                            }
                        }
                    }
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>], descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { ( response ) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        })
                        
                    }
                    
                } else {
                    self._description = ""
                }
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String {
                        
                        if nextEvo.range(of: "mega") == nil {
                            
                            self._nextEvolutionName = nextEvo
                            
                        }
                    }
                    
                    if let uri = evolutions[0]["resource_uri"] as? String {
                        let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                        let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                        
                        self._nextEvolutionID = nextEvoID
                    }
                        
                    if let lvlExst = evolutions[0]["level"] {
                        
                        if let lvl = lvlExst as? Int {
                            self._nextEvolutionLevel = "\(lvl)"
                        }
                        
                    } else {
                        self._nextEvolutionLevel = ""
                    }
                    
                    self._nextEvolutionTxt = "Next Evolution: \(self.nextEvolutionName) - LVL \(self._nextEvolutionLevel!)"
                }
                
                
                
                
                
            }
            
            completed()
        }
    }
    
}
