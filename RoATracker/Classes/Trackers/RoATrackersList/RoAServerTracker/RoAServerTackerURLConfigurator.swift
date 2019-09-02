//
//  RoAServerTackerURLConfigurator.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 12/08/2019.
//
import AdSupport

public struct RoAServerTrackerURLConfigurator {
    
    var deeplink: String?
    
    private let organicDeeplink: String
    
    public var extinfo = RoAExtInfoConfigurator()
    
    public mutating func getUrl() -> URL? {
        guard  deeplink != nil else {
            self.deeplink = organicDeeplink
            return url
        }

        return url
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trk.questmedia.ru"
        components.path = "/application/install"
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: deeplink),
            //        URLQueryItem(name: "adset", value: "adset"),
            URLQueryItem(name: "mobile_cookie", value: mobileCooke),
            URLQueryItem(name: "extinfo", value: extinfo.getExtInfo()),
            URLQueryItem(name: "bundle_id", value: Bundle.main.bundleIdentifier),
            URLQueryItem(name: "fb_bundle_version", value: getFBVersion()),
            URLQueryItem(name: "fb_bundle_short_version", value: getFBShortVertion())
        ]
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
    
    public var mobileCooke: String = {
        var status = ASIdentifierManager.shared().advertisingIdentifier
        return status.uuidString
    }()
    
    public init(organicDeeplink: String) {
        self.organicDeeplink = organicDeeplink
    }
}

public enum RoADeeplickType {
    case apsFlyer, FaceBook
}

