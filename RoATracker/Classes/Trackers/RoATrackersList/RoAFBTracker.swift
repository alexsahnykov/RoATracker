//
//  RoAFBTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import FBSDKCoreKit

import FBSDKCoreKit

public class RoAFBTracker: NSObject  {
    
    public  weak var delegate: RoATrackerManagerDelegate?
    
}

extension RoAFBTracker: RoATracker {
    
    public func event(_ event: EventList) {
        AppEvents.logEvent(AppEvents.Name(event.rawValue))
        testingPrint("[RoA DEBUG Tracker] Facebook event: \(event)" )
    }
    
    public func trial(_ event: Eventable) {
        testingPrint("[RoA DEBUG Tracker] Facebook trial: \(event)" )
        guard let params = event.parameters else {
            AppEvents.logEvent(.startTrial)
            return
        }
        AppEvents.logEvent(.startTrial, parameters: params)
        return
    }
    
    public func customEvent(_ event: Eventable) {
        AppEvents.logEvent(AppEvents.Name(event.eventName))
        testingPrint("[RoA DEBUG Tracker] Facebook customEvent: \(event)" )
    }
    
    public func purchase(_ purchase: Purchase) {
        testingPrint("[RoA DEBUG Tracker] Facebook purchase: \(purchase)" )
        guard let params = purchase.parameters else {
            AppEvents.logPurchase(purchase.valueToSum, currency: purchase.currency)
            return
        }
        AppEvents.logPurchase(purchase.valueToSum, currency: purchase.currency, parameters: params)
    }
    
    public func install() {
        //    AppEvents.activateApp()
    }
}

extension RoAFBTracker: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        AppEvents.activateApp()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        Settings.isAutoLogAppEventsEnabled = false
        
        testingPrint("[RoA DEBUG Tracker] Facebook open")
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        AppEvents.activateApp()
        ApplicationDelegate.shared.application(app, open: url, options: options)
        Settings.isAutoLogAppEventsEnabled = false
        
        testingPrint("[RoA DEBUG Tracker] Facebook open url: \(url)" )
        return true
    }
}
