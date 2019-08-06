//
//  TrackerManagerProtocol.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATrackerManagerProtocol: UIApplicationDelegate {
    
     func add(_ tracker: RoATracker)
    
     func remove(_ tracker: RoATracker)
    
     func get(_ tracker: RoATracker.Type) -> RoATracker?
    
    
}
