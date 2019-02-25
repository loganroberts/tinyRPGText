//
//  AttackMoves.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/22/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class AttackMove {
    var name: String
    var damage: Int
    var criticalChance: Int
    var points: Int
    
    init(data: Dictionary<String, Any>) {
        self.name = data["Name"] as! String
        self.damage = data["Damage"] as! Int
        self.criticalChance = data["CriticalChance"] as! Int
        self.points = data["Points"] as! Int
    }
}
