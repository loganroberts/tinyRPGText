//
//  AI.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

func pathfinder(origin: Tile, target: Tile, map: [[Tile]]) {
    let startTile = map[origin.yLoc][origin.xLoc]
    startTile.parent = nil
    
    let endTile = map[target.yLoc][target.xLoc]
    endTile.parent = nil

    var openList = [Tile]()
    var closedList = [Tile]()
    
    openList.append(startTile)
    
    while openList.count != 0 {
        var currentTile = openList[0]
        var currentIndex = 0
        
        for (index, item) in openList.enumerated() {
            if item.f < currentTile.f {
                currentTile = item
                currentIndex = index
            }
            
            openList.remove(at: currentIndex)
            closedList.append(currentTile)
            
            if (currentTile.yLoc, currentTile.xLoc) == (endTile.yLoc, endTile.xLoc) {
                var path = [Tile]()
                var current: Tile?
                current = currentTile
                while current != nil {
                    path.append(current!)
                    current = current?.parent
                }
                print(path)
                return
            }
            
            var children = [Tile]()
            for each in [(0, -1), (0, 1), (-1, 0), (1, 0)] {
                let tilePosition = ((currentTile.yLoc + each.0), (currentTile.xLoc + each.1))
            
                if tilePosition.0 > (map.count - 1) || tilePosition.0 < 0 || tilePosition.1 > (map[0].count - 1) || tilePosition.1 < 0 {
                    print("Bounds Exceeded")
                    return
                }
                
                let newTile = currentTile
                newTile.parent = currentTile
                newTile.yLoc = tilePosition.0
                newTile.xLoc = tilePosition.1
                
                children.append(newTile)
            }
                
            for child in children {
                for each in closedList {
                    if (child.yLoc, child.xLoc) == (each.yLoc, each.xLoc) {
                        print("Child is on closed list")
                        return
                    } else {
                        child.g = currentTile.g + 1
                        child.h = ((child.yLoc - endTile.yLoc) ** 2) + ((child.xLoc - endTile.xLoc) ** 2)
                        child.f = child.g + child.h
                        for each in openList {
                            if (child.yLoc, child.xLoc) == (each.yLoc, each.xLoc) && child.g > each.g {
                                return
                            }
                        }
                    }
                    openList.append(child)
                }
            }
        }
    }
}
