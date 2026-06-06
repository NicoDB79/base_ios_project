//
//  MulticastDelegate.swift
//  BaseProject
//
//  Created by Nicola De Bei on 10/02/25.
//

import Foundation

class MulticastDelegate <T> {
    private let delegates: NSHashTable<AnyObject> = NSHashTable.weakObjects()
    
    func add(delegate: T) {
        if !delegates.contains(delegate as AnyObject) {
            delegates.add(delegate as AnyObject)
        }
    }
    
    func remove(delegate: T) {
        for oneDelegate in delegates.allObjects.reversed() {
            if oneDelegate === delegate as AnyObject {
                delegates.remove(oneDelegate)
            }
        }
    }
    
    func invoke(invocation: (T) -> ()) {
        for delegate in delegates.allObjects.reversed() {
            invocation(delegate as! T)
        }
    }
    
    func isEmpty() -> Bool {
        return delegates.count == 0
    }
}

func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.add(delegate: right)
}

func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.remove(delegate: right)
}
