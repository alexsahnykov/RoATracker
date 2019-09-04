//
//  RoAAFTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import AppsFlyerLib

public class AFTracker: NSObject {
    
    weak public var delegate: RoATrackerManagerDelegate?
    
    private let appsFlyerDevKey: String
    
    private let appleAppID: String
    
    public init(_ appsFlyerDevKey: String, appleAppID: String) {
        self.appsFlyerDevKey = appsFlyerDevKey.fromBase64() ?? ""
        self.appleAppID = appleAppID
        testingPrint(appsFlyerDevKey.fromBase64() ?? "")
    }
}

 extension AFTracker: RoATracker {
    
   public func install() {
        
    }
    
   public func trial(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(AFEventStartTrial, withValues: event.parameters)
        testingPrint("Appsflyer trial: \(event)")
    }
    
  public  func purchase(_ purchase: Purchase) {
        AppsFlyerTracker.shared().trackEvent(AFEventPurchase, withValues: purchase.parameters)
        testingPrint("Appsflyer purchase: \(purchase)")
    }
    
   public func customEvent(_ event: Eventable) {
        AppsFlyerTracker.shared().trackEvent(event.eventName, withValues: event.parameters)
        testingPrint("Appsflyer event: \(event)")
    }
}

extension AFTracker: UIApplicationDelegate {
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool  {
        AppsFlyerTracker.shared().appsFlyerDevKey = self.appsFlyerDevKey
        AppsFlyerTracker.shared().appleAppID = self.appleAppID 
        AppsFlyerTracker.shared().delegate = self
        AppsFlyerTracker.shared().isDebug = true
        return true
    }
    
   public func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerTracker.shared().trackAppLaunch()
    }
    
   public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return true
    }
    
   public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
}


extension AFTracker: AppsFlyerTrackerDelegate {
    
   public func onConversionDataReceived(_ installData: [AnyHashable: Any]) {
        delegate?.getDeeplink(.appsflyer, deeplink: installData)
        testingPrint("OnConversionDataReceived \(installData)")
    }
    
   public func onAppOpenAttribution(_ attributionData: [AnyHashable: Any]) {
        delegate?.getDeeplink(.appsflyer, deeplink: attributionData)
        testingPrint("OnAppOpenAttribution \(attributionData)")
    }
    
}
