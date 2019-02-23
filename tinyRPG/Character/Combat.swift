//
//  Combat.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation

class CombatSystem {
    var owner: Character
    var target: Character? = nil
    var active = false
    
    let d20: [Int] = Array(1...20)
    let d100: [Int] = Array(1...100)
    let d6: [Int] = Array(1...6)
    
    var baseAttack: Int {
        let _a = owner.experience.level * 2
        let _b = owner.attributes.strength.modifier
        let _c = owner.inventory.weaponSlot?.damage ?? 0
        return _a + _b + _c
    }
    
    var baseDefense: Int {
        let _a = owner.experience.level * 2
        let _b = owner.inventory.headSlot?.defense ?? 0
        let _c = owner.inventory.handsSlot?.defense ?? 0
        let _d = owner.inventory.bodySlot?.defense ?? 0
        let _e = owner.inventory.feetSlot?.defense ?? 0
        let _f = owner.attributes.speed.bonus
        return _a + _b + _c + _d + _e + _f
    }
    
    var accuracy: Int {
        let _a = owner.inventory.weaponSlot?.accuracy ?? 75
        return _a
    }
    
    var iniative: Int {
        let _a = owner.attributes.speed.bonus
        let _b = d6.randomElement()!
        return _a + _b
    }
    
    init(owner: Character) {
        self.owner = owner
    }
    
    func combatStarted(with: Character) {
        owner.state = .inCombat
        target = with
        target?.combat.target = owner
        rollIniative()
        if active == true {
            combatLoop()
        } else {
            target?.combat.targetTurn()
            combatLoop()
        }
    }
    
    func combatLoop() {
        while (target!.state != .dead) && (owner.state != .dead) {
            print("Attack?")
            if readLine() == "y" {
            attackAction()
            } else {
                print("You skipped your turn")
            }
            if target?.state != .dead {
            target?.combat.targetTurn()
            }
        }
        postCombat()
    }
    
    func targetTurn() {
        targetAttackAction()
    }
    
    func rollIniative() {
        guard iniative >= (target?.combat.iniative)! else {
            active = false
            target?.combat.active = true
            return
        }
        active = true
        target?.combat.active = false
    }
    
    func rollForHit() -> Bool {
        let roll = d20.randomElement()!
        var result = false
        
        if roll == 20 {
            result = true
        } else if roll == 1 {
            result = false
        } else if roll + baseAttack >= ((target?.combat.baseDefense)! + d6.randomElement()!) {
            result = true
        } else {
            result = false
        }
        return result
    }
    
    func rollCritical() -> Int {
        var result = 1
        
        let probability: [Int] = Array(1...100)
        let threshold = (owner.inventory.weaponSlot?.move.criticalChance ?? 0) * d20.randomElement()!
        
        if probability.randomElement()! <= threshold {
            result = 2
        } else {
            result = 1
        }
        return result
    }
    
    func determineDamage() -> Int {
    
        let _damage = (owner.inventory.weaponSlot?.move.damage)! * rollCritical()
        let _power = owner.attributes.strength.bonus
        
        return _damage + _power
    }
    
    func attackAction() {
        guard rollForHit() == true else {
            print("You Missed")
            return
        }
        let damage = determineDamage()
        target?.combat.takeDamage(amount: damage)
        
        var number = target!.attributes.health.current
        if number <= 0 {
            number = 0
        }
    }
    
    func targetAttackAction() {
        guard rollForHit() == true else {
            print("The enemy Missed")
            return
        }
        let damage = determineDamage()
        target?.combat.takeDamage(amount: damage)
        
        var number = target!.attributes.health.current
        if number <= 0 {
            number = 0
        }
    }
    
    func takeDamage(amount: Int) {
        owner.attributes.takeDamage(amount: amount)
    }
    
    func postCombat() {
       guard owner.state != .dead else {
            print("You Died")
            return
            //end game interface
        }
        if target?.state == .dead {
            let xp = target?.experience.dropXP
            let _xp = Double(round(1*xp!)/1)
            print("You Killed the enemy! You got \(_xp) XP!")
            owner.experience.combatComplete(xpDrop: xp ?? 0)
        }
    }
}
