//
//  PlayerView.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/22/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class PlayerView {
    var world: TileMap
    var playerView = [[Tile]]()
    var height = 6
    var width = 6
    var originX = 0
    var originY = 0
    
    lazy var originTile = world.map[originY][originX]
    
    var view = [[Tile]]()
    
    init(world: TileMap) {
        self.world = world
        playerView = showView(y: originY, x: originX)
    }
    
    func showView(y: Int, x: Int) -> [[Tile]]{
        var view = [[Tile]]()
        var count = 0
        for _ in 1...width {
            var _count = 0
            var _view = [Tile]()
            for _ in 1...height {
                _view.append(world.map[y + count][x + _count])
                _count += 1
            }
            view.append(_view)
            count += 1
        }
        return view
    }
    
    func moveViewSouth() {
        originY += 1
        playerView = showView(y: originY, x: originX)
    }
    
    func printMap() {
        var printArray = [[String]]()
        for each in playerView {
            var parray = [String]()
            for item in each {
                parray.append(item.type.rawValue)
            }
            printArray.append(parray)
        }
        for rows in printArray {
            print(rows)
        }
    }
    
}
