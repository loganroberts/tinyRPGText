//
//  main.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation
import AppKit

let gameData = getDefaults(name: "Defaults")

let world = World(width: 1000, height: 1000)

world.playerView.printMap()

print("press s to move south")
if readLine() == "s" {
    world.playerView.moveViewSouth()
    world.playerView.printMap()
}
