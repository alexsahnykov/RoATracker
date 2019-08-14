//
//  RoAFBTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import FBSDKCoreKit

public class RoAFBTracker: NSObject, RoATracker  {
   
    public func createEvent(_ eventNmae: String) {
        
    }
    
   
    public func purchase() {
        AppEvents.logPurchase(21, currency: "Dollar")
    }
    
    public func registerTracker(_ deeplink: NSURL? = nil) {
        
    }
    
    
    public func install() {
        print("FB install")
    }
    
}

extension RoAFBTracker: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
        return true
    }
    
}



