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
    
    var worldMap: TileMap
    var playerView: PlayerView
    
    
    init(width: Int, height: Int) {
        self.worldMap = TileMap(height: height, width: width)
        self.playerView = PlayerView(world: worldMap)
    }
    
    
    
    
}
