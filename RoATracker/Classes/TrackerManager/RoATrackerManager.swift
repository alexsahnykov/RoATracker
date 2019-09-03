//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public class RoATrackerManager: NSObject {
    
    public var delegate: RoATrackerManagerDelegate?
    
    public static let shared = RoATrackerManager()
    
    var trackers: [RoATracker] = []
    
    private override init() {}
    
}

extension RoATrackerManager: RoATracker {

    public func install() {
        trackers.forEach {$0.install()}
    }
    
    public func purchase(_ purchase: Purchase) {
        trackers.forEach {$0.purchase(purchase)}
    }
    
    public func customEvent(_ event: Eventable) {
        trackers.forEach {$0.customEvent(event)}
    }
    
    public func trial(_ event: Eventable) {
        trackers.forEach {$0.trial(event)}
    }
    
    
}

extension RoATrackerManager: RoATrackerManagerProtocol {
    
    public func get(_ tracker: RoATracker.Type) -> RoATracker? {
        let obj = trackers.filter {type(of: $0) === tracker}
        return obj.first
    }
    
    public func add(_ tracker: RoATracker) {
        let isContain = trackers.contains {$0 === tracker }
        guard !isContain else {
            testingPrint("Tracker allready added")
            return}
        tracker.delegate = self
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
        trackers.forEach {_ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions)}
        return true
    }
    
   public func applicationDidBecomeActive(_ application: UIApplication) {
        trackers.forEach {$0.applicationDidBecomeActive?(application)
        }
    }
    
   public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        trackers.forEach {_ = $0.application?(app, open: url, options: options)}
        return true
    }
    
}

extension RoATrackerManager: RoATrackerManagerDelegate {
    
    public func getDeeplink(_ type: DeeplinkType, deeplink: [AnyHashable : Any]) {
            guard let tracker = self.get(RoAServerTracker.self) as? RoAServerTracker else {return}
        tracker.getServerId(type)
    }
 
}
