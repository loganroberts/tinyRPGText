//
//  Movement.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class MovementSystem {
    var owner: Character
    
    init(owner: Character) {
        self.owner = owner
    }
    
    func move(direction: World.Direction) {
        switch direction {
        case .north:
            owner.world.playerView.moveNorth()
            print("You moved North.")
        case .south:
            owner.world.playerView.moveSouth()
            print("You moved South.")
        case .east:
            owner.world.playerView.moveEast()
            print("You moved East.")
        case .west:
            owner.world.playerView.moveWest()
            print("You moved West.")
        }
    }
    
    
    
}
