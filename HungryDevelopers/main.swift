//
//  main.swift
//  HungryDevelopers
//
//  Created by Sean Acres on 8/7/19.
//  Copyright © 2019 Sean Acres. All rights reserved.
//

import Foundation

print("Hello, World!")

class Spoon {
    private var lock = NSLock()
    var index: Int = 0
    
    func pickUp() {
        lock.lock()
    }
    
    func putDown() {
        lock.unlock()
    }
}

class Developer {
    var leftSpoon: Spoon = Spoon()
    var rightSpoon: Spoon = Spoon()
    var name: String = ""
    
    init(name: String) {
        self.name = name
    }
    
    func think() {
        if leftSpoon.index < rightSpoon.index {
            leftSpoon.pickUp()
            rightSpoon.pickUp()
        } else {
           rightSpoon.pickUp()
           leftSpoon.pickUp()
        }
        
        
        print("\(name) is thinking")
    }
    
    func eat() {
        print("\(name) is eating")
        usleep(10000)
        rightSpoon.putDown()
        leftSpoon.putDown()
        
        print("\(name) is done eating")
    }
    
    func run() {
        let shouldRun = true
        while shouldRun {
            think()
            eat()
        }
    }
}

let dev1 = Developer(name: "dev1")
let dev2 = Developer(name: "dev2")
let dev3 = Developer(name: "dev3")
let dev4 = Developer(name: "dev4")
let dev5 = Developer(name: "dev5")

var developers: [Developer] = [dev1, dev2, dev3, dev4, dev5]

dev1.leftSpoon = dev5.rightSpoon
dev2.leftSpoon = dev1.rightSpoon
dev3.leftSpoon = dev2.rightSpoon
dev4.leftSpoon = dev3.rightSpoon
dev5.leftSpoon = dev4.leftSpoon

dev1.leftSpoon.index = 1
dev2.leftSpoon.index = 2
dev3.leftSpoon.index = 3
dev4.leftSpoon.index = 4
dev5.leftSpoon.index = 5


DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
