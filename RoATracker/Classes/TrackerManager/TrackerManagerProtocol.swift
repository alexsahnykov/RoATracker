//
//  TrackerManagerProtocol.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATrackerManagerProtocol {
    
    func add(_ tracker: RoATracker)
    
    func remove(_ tracker: RoATracker)
    
    func checkSubInAll()
    
    func checkSubIn(_ tracker: RoATracker)
    
    
}
