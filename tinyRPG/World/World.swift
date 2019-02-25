//
//  World.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation


///acutal world holding tiles and maps etc
class World {
    
    enum Direction {
        case north
        case south
        case east
        case west
    }
    
    var playerView: MapView
    
    init(width: Int, height: Int) {
        self.playerView = MapView(width: width, height: height)
    }
    
    
    
    
}
