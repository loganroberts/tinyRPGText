//
//  Attributes.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class Attribute: Subject {
    var owner: Character
    var base: Int
    var max: Int
    
    init(owner: Character, withData: Dictionary<String, Any>, name: String) {
        self.base = withData["Base"] as! Int
        self.max = base
        self.owner = owner
        super.init()
        self.name = name
        self.current = max
        setupObservers(subject: self)
    }
    
    override func attributeDepleated() {
        owner.attributes.attributeDepleated(attribute: name)
    }
}

class Ability {
    var owner: Character
    var level: Int
    var modifier: Int
    var bonus: Int
    
    init(owner: Character, withData: Dictionary<String, Any>) {
        self.owner = owner
        self.level = withData["Level"] as! Int
        self.modifier = withData["Modifier"] as! Int
        self.bonus = withData["Bonus"] as! Int
    }
}

class AttributeSystem {
    var owner: Character
    
    lazy var health = Attribute(owner: owner, withData: owner.defaults, name: "Health")
    lazy var stamina = Attribute(owner: owner, withData: owner.defaults, name: "Stamina")
    lazy var magic = Attribute(owner: owner, withData: owner.defaults, name: "Magic")
    
    lazy var strength = Ability(owner: owner, withData: owner.defaults)
    lazy var speed = Ability(owner: owner, withData: owner.defaults)
    lazy var constitution = Ability(owner: owner, withData: owner.defaults)
    lazy var intelligence = Ability(owner: owner, withData: owner.defaults)
    
    init(owner: Character) {
        self.owner = owner
        
        health = Attribute(owner: owner, withData: ((gameData["RaceDefaults"] as! Dictionary<String, Any>)[owner.race.rawValue] as! Dictionary<String, Any>)["Health"] as! Dictionary<String, Any>, name: "Health")
        stamina = Attribute(owner: owner, withData: ((gameData["RaceDefaults"] as! Dictionary<String, Any>)[owner.race.rawValue] as! Dictionary<String, Any>)["Stamina"] as! Dictionary<String, Any>, name: "Stamina")
        magic = Attribute(owner: owner, withData: ((gameData["RaceDefaults"] as! Dictionary<String, Any>)[owner.race.rawValue] as! Dictionary<String, Any>)["Magic"] as! Dictionary<String, Any>, name: "Magic")
        
        strength = Ability(owner: owner, withData: ((gameData["ClassDefaults"] as! Dictionary<String, Any>)[owner.kind.rawValue] as! Dictionary<String, Any>)["Strength"] as! Dictionary<String, Any>)
        speed = Ability(owner: owner, withData: ((gameData["ClassDefaults"] as! Dictionary<String, Any>)[owner.kind.rawValue] as! Dictionary<String, Any>)["Speed"] as! Dictionary<String, Any>)
        constitution = Ability(owner: owner, withData: ((gameData["ClassDefaults"] as! Dictionary<String, Any>)[owner.kind.rawValue] as! Dictionary<String, Any>)["Constitution"] as! Dictionary<String, Any>)
        intelligence = Ability(owner: owner, withData: ((gameData["ClassDefaults"] as! Dictionary<String, Any>)[owner.kind.rawValue] as! Dictionary<String, Any>)["Intelligence"] as! Dictionary<String, Any>)
    }
    
    func takeDamage(amount: Int) {
        health.current -= amount
    }
    
    func attributeDepleated(attribute: String) {
        if attribute == "Health" {
            owner.state = .dead
        }
    }
}
