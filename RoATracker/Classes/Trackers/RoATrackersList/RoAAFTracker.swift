//
//  RoAAFTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import AppsFlyerLib

public class RoAAFTracker: NSObject {
    
    weak public var delegate: RoATrackerManagerDelegate?
    
    private let appsFlyerDevKey: String
    
    private let appleAppID: String
    
    public init(_ appsFlyerDevKey: String, appleAppID: String) {
        self.appsFlyerDevKey = appsFlyerDevKey.fromBase64() ?? ""
        self.appleAppID = appleAppID
        testingPrint("[RoA Tracker DEBUG] Appsflyer id: \(appsFlyerDevKey.fromBase64() ?? "")")
    }
}

extension RoAAFTracker: RoATracker {
   
    
    public func event(_ event: EventList) {
        AppsFlyerTracker.shared()?.trackEvent(event.rawValue, withValues: [:])
        testingPrint("[RoA Tracker DEBUG] Appsflyer event: \(event)")
    }
    
    public func install() {
        
    }
    
    public func trial(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(AFEventStartTrial, withValues: event.parameters)
        testingPrint("[RoA Tracker DEBUG] Appsflyer trial: \(event)")
    }
    
    public  func purchase(_ purchase: Purchase) {
        let params: [String : Any] = [AFEventParamPrice: purchase.valueToSum]
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: params)
        testingPrint(" [RoA Tracker DEBUG] Appsflyer purchase: \(purchase)")
    }
    
    public func customEvent(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(event.eventName, withValues: event.parameters)
        testingPrint("[RoA Tracker DEBUG] Appsflyer custom event: \(event)")
    }
}

extension RoAAFTracker: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        AppsFlyerTracker.shared().appsFlyerDevKey = self.appsFlyerDevKey
        AppsFlyerTracker.shared().appleAppID = self.appleAppID
        AppsFlyerTracker.shared().delegate = self
        AppsFlyerTracker.shared().isDebug = false
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        self.delegate?.getDeeplink(.appsflyer, deeplink: options)
        testingPrint("[RoA Tracker DEBUG] OnConversionDataReceived \(options)")
        return true
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
}


extension RoAAFTracker: AppsFlyerTrackerDelegate {
    
    public func onConversionDataReceived(_ installData: [AnyHashable: Any]) {
        DispatchQueue.main.async {
            self.delegate?.getDeeplink(.appsflyer, deeplink: installData)
            testingPrint("[RoA Tracker DEBUG] OnConversionDataReceived \(installData)")
        }
    }
    
    public func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        DispatchQueue.main.async {
            self.delegate?.getDeeplink(.appsflyer, deeplink: attributionData)
            testingPrint("[RoA Tracker DEBUG] OnAppOpenAttribution \(attributionData)")
        }
    }
}
