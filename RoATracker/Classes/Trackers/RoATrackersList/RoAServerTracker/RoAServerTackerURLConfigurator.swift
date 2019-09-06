//
//  RoAServerTackerURLConfigurator.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 12/08/2019.
//
import AdSupport

public struct RoAServerTrackerURLConfigurator {
    
    var deeplink: String? {
        willSet {
            testingPrint("[RoA Tracker server] Set new deeplink: \(newValue ?? "No new value")")
        }
    }
    
   private var components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trk.questmedia.ru"
        components.path = "/application/install"
        return components
    }()
    
    private var extinfo = RoAExtInfoConfigurator()
    
    public  func getInstallUrl(_ deeplinkType: DeeplinkType) -> URL? {
        switch deeplinkType {
        case .appsflyer:
            testingPrint("[RoA Tracker server]: build appsflyer url \(String(describing: components.url))")
            return appsflyerUrl
        case .facebook:
            testingPrint("[RoA Tracker server]: build facebook url \(String(describing: components.url))")
            return facebookUrl
        }
    }
    
    public func getPurchaseUrl(_ id: String, transactionID: String) -> URL? {
        var components = self.components
        components.path = "/application/purchase"
        let bundle = Bundle.main.bundleIdentifier ?? "noBundle"
        components.queryItems = [
            URLQueryItem(name: "id", value: id),
            URLQueryItem(name: "original_transaction_id", value: transactionID),
            URLQueryItem(name: "bundle_id", value: bundle),
        ]
        testingPrint("[RoA Tracker server]: build server purchase url \(String(describing: components.url))")
        return components.url
    }
    
    private var facebookUrl: URL? {
        var components = self.components
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: deeplink),
            URLQueryItem(name: "mobile_cookie", value: mobileCooke),
            URLQueryItem(name: "extinfo", value: extinfo.getExtInfo()),
            URLQueryItem(name: "bundle_id", value: Bundle.main.bundleIdentifier),
            URLQueryItem(name: "fb_bundle_version", value: getFBVersion()),
            URLQueryItem(name: "fb_bundle_short_version", value: getFBShortVertion())]
        return components.url
    }
    
    private var appsflyerUrl: URL? {
        var components = self.components
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: deeplink),
            URLQueryItem(name: "adset", value: "adset"),
            URLQueryItem(name: "mobile_cookie", value: mobileCooke),
            URLQueryItem(name: "extinfo", value: extinfo.getExtInfo()),
            URLQueryItem(name: "bundle_id", value: Bundle.main.bundleIdentifier),
            URLQueryItem(name: "fb_bundle_version", value: getFBVersion()),
            URLQueryItem(name: "fb_bundle_short_version", value: getFBShortVertion())]
        return components.url
    }
    
    
    private func getFBVersion() -> String? {
        guard let dictionary = Bundle.main.infoDictionary else {return nil}
        let version = dictionary["CFBundleVersion"] as! String
        return version
    }
    
    private func getFBShortVertion() -> String? {
        guard let dictionary = Bundle.main.infoDictionary else {return nil}
        let version = dictionary["CFBundleShortVersionString"] as! String
        return version
    }
    
    private var mobileCooke: String = {
        var status = ASIdentifierManager.shared().advertisingIdentifier
        return status.uuidString
    }()
    
    public init(organicDeeplink: String) {
        self.deeplink = organicDeeplink
    }
}
