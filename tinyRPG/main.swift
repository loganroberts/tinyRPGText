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
player.movement.move(direction: .north)

pathfinder(origin: world.playerView.playerView[3][3], target: world.playerView.playerView[1][1], map: world.playerView.playerView)
