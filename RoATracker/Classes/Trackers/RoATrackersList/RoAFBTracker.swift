//
//  RoAFBTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import FBSDKCoreKit

public class RoAFBTracker: NSObject  {
    
    public  weak var delegate: RoATrackerManagerDelegate?
    
}

extension RoAFBTracker: RoATracker {

    public func trial(_ name: Eventable) {
        guard let params = name.parameters else {
            AppEvents.logEvent(.startTrial)
            return
        }
        AppEvents.logEvent(.startTrial, parameters: params)
        return
    }
    
    public func customEvent(_ event: Eventable) {
        AppEvents.logEvent(AppEvents.Name(event.eventName))
    }
    
    public func purchase(_ purchase: Purchase) {
        guard let params = purchase.converToParams() else {
            AppEvents.logPurchase(purchase.valueToSum, currency: purchase.currency)
            return
        }
        AppEvents.logPurchase(purchase.valueToSum, currency: purchase.currency, parameters: params)
    }
    
    public func install() {
        AppEvents.activateApp()
    }
}

extension RoAFBTracker: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        Settings.isAutoLogAppEventsEnabled = false
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
        Settings.isAutoLogAppEventsEnabled = false
        return true
    }
}
