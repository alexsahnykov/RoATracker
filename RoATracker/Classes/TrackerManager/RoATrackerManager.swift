//
//  RoATrackerManager.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATrackerManagerDelegate: class {
    
    func getDeeplink(_ : [AnyHashable: Any])
    
}

public class RoATrackerManager: NSObject {
    
    public static let shared = RoATrackerManager()
    
   // var deepLink: RoADeeplinkManager?
    
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
    
    
public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
      //  AppsFlyerTracker.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
}

extension RoATrackerManager: RoATrackerManagerDelegate {
   
    public func getDeeplink(_: [AnyHashable : Any]) {
        guard let tracker = self.get(RoAServerTracker.self) as? RoAServerTracker else {return}
     //   tracker.
    }
    
}
