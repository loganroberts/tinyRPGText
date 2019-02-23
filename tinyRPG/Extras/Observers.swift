//
//  Observers.swift
//  tinyRPG
//
//  Created by Logan Roberts on 2/21/19.
//  Copyright © 2019 Logan Roberts. All rights reserved.
//

import Foundation
//Observer Protocol
protocol Observer {
    var id: Int { get }
    func update()
}

//subject class, inheritied by Player, Enemy
class Subject {
    //list of observers
    private var observerArray = [Observer]()
    //Character attributes
    
    private var _current = Int()
    var name = String()
    
    var current: Int {
        set {
            _current = newValue
            notify()
        } get {
            return _current
        }
    }
    
    //add the observers to the objects array
    func attachObserver(observer: Observer) {
        observerArray.append(observer)
    }
    
    func attributeDepleated() {
        
    }
    
    //calls the update() func in each observer
    private func notify() {
        for each in observerArray {
            each.update()
        }
    }
    
}


class HealthObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        if subject.current <= 0 {
        subject.attributeDepleated()
        }
    }
    
}

class StaminaObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        if subject.name == "Stamina" {
            print("Stamina Changed")
        }
    }
    
}

class MagicObserver: Observer {
    private var subject = Subject()
    var id = Int()
    
    init(subject: Subject, id: Int) {
        self.subject = subject
        self.subject.attachObserver(observer: self)
        self.id = id
    }
    
    func update() {
        if subject.name == "Magic" {
            print("Magic Changed")
        }
    }
    
}

func setupObservers(subject: Subject) {
    let _ = HealthObserver(subject: subject, id: 1)
}
