//
//  main.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation
import AppKit

let game = true

let gameData = getDefaults(name: "Defaults")

let world = World(width: 1000, height: 1000)
let player = Character(withData: gameData["CharacterDefaults"] as! Dictionary<String, Any>, name: "Logan", world: world)

world.playerView.printMap()

while 1 > 0 {
    print("move: n s e w")
    switch readLine() {
    case "n":
        player.movement.move(direction: .north)
        world.playerView.printMap()
    case "s":
        player.movement.move(direction: .south)
        world.playerView.printMap()
    case "e":
        player.movement.move(direction: .east)
        world.playerView.printMap()
    case "w":
        player.movement.move(direction: .west)
        world.playerView.printMap()
    default:
        print("Make a choice")
    }
}
