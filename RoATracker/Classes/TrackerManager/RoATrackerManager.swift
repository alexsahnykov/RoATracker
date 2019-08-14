//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoATrackerManager: NSObject {
    
    public static let shared = RoATrackerManager()
    
    var deepLink: RoADeeplinkManager?
    
    var trackers: [RoATracker] = []
    
    private override init() {}
    
}

extension RoATrackerManager: RoATrackerManagerProtocol {
    
    public func get(_ tracker: RoATracker.Type) -> RoATracker? {
        let obj = trackers.filter {type(of: $0) === tracker}
        return obj.first
    }
    
    public func add(_ tracker: RoATracker) {
        let isContain = trackers.contains {$0 === tracker }
        guard !isContain else {
            print("Tracker allready added")
            return}
        trackers.append(tracker)
    }
    
    public func remove(_ tracker: RoATracker) {
        trackers.remove(tracker as AnyObject)
    }
    
    public func checkSubInAll() {
        trackers.forEach() {$0.install()}
    }
    
}

extension RoATrackerManager: UIApplicationDelegate  {
    
    public  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // serverID = getID()
        for tracker in trackers {
            let _ = tracker.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        return true
    }
}

