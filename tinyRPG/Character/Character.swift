//
//  Character.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class Character {
    enum PlayerState {
        case idle
        case inCombat
        case managingInventory
        case dead
    }
    
    enum CharacterRace: String {
        case human = "Human"
        case elf = "Elf"
    }
    
    enum CharacterKind: String {
        case warrior = "Warrior"
        case archer = "Archer"
    }
    
    var defaults: Dictionary<String, Any>
    
    var name: String
    var race: CharacterRace
    var kind: CharacterKind
    var state = PlayerState.idle
    var world: World
    
    lazy var movement = MovementSystem(owner: self)
    lazy var attributes = AttributeSystem(owner: self)
    lazy var inventory = InventorySystem(owner: self)
    lazy var experience = ExperienceSystem(owner: self)
    lazy var combat = CombatSystem(owner: self)
    
    init(withData: Dictionary<String, Any>, name: String, world: World) {
        self.defaults = withData
        self.name = name
        self.world = world
        self.race = CharacterRace.init(rawValue: defaults["Race"] as! String)!
        self.kind = CharacterKind.init(rawValue: defaults["Kind"] as! String)!
        movement = MovementSystem(owner: self)
        attributes = AttributeSystem(owner: self)
        movement = MovementSystem(owner: self)
        inventory = InventorySystem(owner: self)
        inventory.setupDefaultEquipment()
        combat = CombatSystem(owner: self)
    }
    
}
