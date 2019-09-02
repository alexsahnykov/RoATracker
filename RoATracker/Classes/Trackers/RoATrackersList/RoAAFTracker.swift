//
//  RoAAFTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import AppsFlyerLib

class AFTracker: NSObject {
    
    weak var delegate: RoATrackerManagerDelegate?
    
    private let appsFlyerDevKey: String
    
    private let appleAppID: String
    
    public init(_ appsFlyerDevKey: String, appleAppID: String) {
        self.appsFlyerDevKey = appsFlyerDevKey.fromBase64() ?? ""
        self.appleAppID = appleAppID
    }
}

extension AFTracker: RoATracker {
    
    func install() {
        
    }
    
    func trial(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(AFEventStartTrial, withValues: event.parameters)
    }
    
    func purchase(_ purchase: Purchase) {
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: purchase.parameters)
    }
    
    func customEvent(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(event.eventName, withValues: event.parameters)
    }
}

extension AFTracker: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        AppsFlyerTracker.shared().appsFlyerDevKey = self.appsFlyerDevKey
        AppsFlyerTracker.shared().appleAppID = self.appleAppID 
        AppsFlyerTracker.shared().delegate = self
        AppsFlyerTracker.shared().isDebug = true
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
}


extension AFTracker: AppsFlyerTrackerDelegate {
    
    func onConversionDataReceived(_ installData: [AnyHashable: Any]) {
        delegate?.getDeeplink(installData)
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        delegate?.getDeeplink(attributionData)
        
    }
    
}
