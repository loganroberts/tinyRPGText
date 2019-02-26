//
//  MapView.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/22/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation
import AppKit

class MapView {

    var playerView = [[Tile]]()
    var height = 7
    var width = 7
    
    var worldOriginX = 0
    var worldOriginY = 0
    
    var viewOriginX = 3
    var viewOriginY = 3
    
    lazy var originTile = perlinNoise[worldOriginY][worldOriginX]

    var view = [[Tile]]()
    var perlinNoise = [[Double]]()
    
    var columns: Int
    var rows: Int

    lazy var lastTile = playerView[worldOriginY][worldOriginX]
    
    var isCenter: Bool {
        return viewOriginY == 3 || viewOriginX == 3
    }
    
    init(width: Int, height: Int) {
        self.rows = width / 10
        self.columns = height / 10
        
        perlinNoise = NoiseGenerator.sharedInstance.GeneratePerlinNoise(width: rows, height: columns, octaveCount: 8)
        //NoiseGenerator.sharedInstance.generateNoiseImage(size: CGSize(width: 500, height: 500))
        playerView = showView(y: worldOriginY, x: worldOriginX)
        moveAvatar()
    }
    
    func showView(y: Int, x: Int) -> [[Tile]]{
        var view = [[Tile]]()
        var count = 0
        for _ in 1...width {
            var _count = 0
            var _view = [Tile]()
            for _ in 1...height {
                _view.append(Tile(yLoc: y + count, xLoc: x + _count, terrain: perlinNoise[y + count][x + _count]))
                _count += 1
            }
            view.append(_view)
            count += 1
        }
        return view
    }
    
    func worldIndexIsValid() -> Bool {
        return worldOriginX >= 0 && worldOriginX < perlinNoise[0].count && worldOriginY >= 0 && worldOriginY < perlinNoise.count
    }
    
    func viewIndexisValid() -> Bool {
        return viewOriginX >= 0 && viewOriginX < playerView[0].count && viewOriginY >= 0 && viewOriginY < playerView.count
    }
    
    func moveAvatar() {
        lastTile = playerView[viewOriginY][viewOriginX]
        playerView[viewOriginY][viewOriginX].type = .player
    }
    

    func move(direction: World.Direction) {
        switch direction {
        case .north:
            moveNorth()
            print("You moved North.")
        case .south:
            moveSouth()
            print("You moved South.")
        case .east:
            moveEast()
            print("You moved East.")
        case .west:
            moveWest()
            print("You moved West.")
        }
    }
        
    func moveNorth() {
        guard viewOriginY == 3 else {
            viewOriginY -= 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                viewOriginY += 1
                return
            }
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        //View is in center, move it to out of center if at side of map
        worldOriginY -= 1
        guard worldIndexIsValid() == true else {
            viewOriginY -= 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                worldOriginY += 1
                viewOriginY += 1
                return
            }
            worldOriginY += 1
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        playerView = showView(y: worldOriginY, x: worldOriginX)
        moveAvatar()
    }
    
    func moveSouth() {
        guard viewOriginY == 3 else {
            viewOriginY += 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                viewOriginY -= 1
                return
            }
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        //View is in center, move it to out of center if at side of map
        worldOriginY += 1
        guard worldIndexIsValid() == true else {
            viewOriginY += 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                worldOriginY -= 1
                viewOriginY -= 1
                return
            }
            worldOriginY -= 1
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        playerView = showView(y: worldOriginY, x: worldOriginX)
        moveAvatar()
    }
    
    
    func moveEast() {
        guard viewOriginX == 3 else {
            viewOriginX += 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                viewOriginX -= 1
                return
            }
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        //View is in center, move it to out of center if at side of map
        worldOriginX += 1
        guard worldIndexIsValid() == true else {
            viewOriginX += 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                worldOriginX -= 1
                viewOriginX -= 1
                return
            }
            worldOriginX -= 1
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        playerView = showView(y: worldOriginY, x: worldOriginX)
        moveAvatar()
    }
    
    func moveWest() {
        guard viewOriginX == 3 else {
            viewOriginX -= 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                viewOriginX += 1
                return
            }
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        //View is in center, move it to out of center if at side of map
        worldOriginX -= 1
        guard worldIndexIsValid() == true else {
            viewOriginX -= 1
            guard viewIndexisValid() == true else {
                print("You can't move there")
                worldOriginX += 1
                viewOriginX += 1
                return
            }
            worldOriginX += 1
            playerView = showView(y: worldOriginY, x: worldOriginX)
            moveAvatar()
            return
        }
        playerView = showView(y: worldOriginY, x: worldOriginX)
        moveAvatar()
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
