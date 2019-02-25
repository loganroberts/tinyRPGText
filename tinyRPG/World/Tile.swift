//
//  Tile.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/22/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

struct Tile {
    enum Terrain: String{
        case blank = "Blank"
        case player = "8"
        case grass = "."
        case water = "~"
        case sand = "s"
        case forest = "t"
        case mountain = "∆"
    }
    
    var type = Terrain.blank
    var canSpawn = true
    var onscreen = false

    var occupied = false
    var cost = 1
    var yLoc: Int
    var xLoc: Int
    
    var width = 10
    var height = 10
    
    init(yLoc: Int, xLoc: Int, terrain: Double) {
        self.yLoc = yLoc
        self.xLoc = xLoc
        
        switch terrain {
        case 0...0.4:
            self.type = Terrain.water
            self.canSpawn = false
            self.cost = 5
            break
        case 0.4...0.5:
            self.type = Terrain.sand
            self.canSpawn = false
            self.cost = 2
            break
        case 0.5...0.8:
            self.type = Terrain.grass
            self.canSpawn = true
            self.cost = 1
            break
        case 0.8...0.9:
            self.type = Terrain.forest
            self.canSpawn = true
            self.cost = 3
            break
        case 0.9...1:
            self.type = Terrain.mountain
            self.canSpawn = true
            self.cost = 4
            break
        default:
            self.type = Terrain.grass
            self.cost = 1
            self.canSpawn = true
        }
    }
}
