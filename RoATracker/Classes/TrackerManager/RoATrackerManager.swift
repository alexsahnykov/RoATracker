//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoATrackerManager {
    
    static let shared = RoATrackerManager()
    
    private init() {}
    
    var trackers: [RoATracker] = []
    
    
}

extension RoATrackerManager: RoATrackerManagerProtocol {
    
    public func add(_ tracker: RoATracker) {
        trackers.append(tracker)
    }
    
    public func remove(_ tracker: RoATracker) {
        trackers.remove(tracker as AnyObject)
    }
    
    public func checkSubIn(_ tracker: RoATracker) {
        tracker.install()
    }
    
    public func checkSubInAll() {
        trackers.forEach() {$0.install()}
    }
    
}
