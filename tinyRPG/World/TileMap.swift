//
//  TileMap.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

class TileMap {
    
    var map = [[Tile]]()
    var perlinNoise = [[Double]]()
    
    var columns: Int
    var rows: Int
    
    init(height: Int, width: Int) {
        self.rows = width / 10
        self.columns = height / 10
        
        perlinNoise = NoiseGenerator.sharedInstance.GeneratePerlinNoise(width: rows, height: columns, octaveCount: 8)
        setupMap()
    }
    
    func setupMap() {
        var yCount = 0
        
        for i in 0...(perlinNoise.count - 1) {
            var xCount = 0
            var array = [Tile]()
            
            for j in 0...(perlinNoise[0].count - 1) {
                array.append(Tile(yLoc: i, xLoc: j, terrain: perlinNoise[i][j]))
                xCount += 1
            }
            map.append(array)
            yCount += 1
        }
    }
    
    func printMap() {
        var printArray = [[String]]()
        for each in map {
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
