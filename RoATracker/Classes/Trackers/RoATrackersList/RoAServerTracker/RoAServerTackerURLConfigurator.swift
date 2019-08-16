//
//  RoAServerTackerURLConfigurator.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 12/08/2019.
//

public struct RoAServerTackerURLConfigurator {
    
    public var deeplink: NSURL?
    
    public var extinfo = RoAExtInfoConfigurator()
    
    public func getUrl() -> URL? {
        return url
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "trk.questmedia.ru"
        components.path = "/application/install"
        components.queryItems = [
            URLQueryItem(name: "deeplink", value: deeplink?.absoluteString),
            //        URLQueryItem(name: "adset", value: "adset"),
            URLQueryItem(name: "mobile_cookie", value: "99c4cab0-526b-47bc-b1b1-c34d27b62897"),
            URLQueryItem(name: "extinfo", value: extinfo.getExtInfo()),
            URLQueryItem(name: "bundle_id", value: "com.app.deeplinks"),
            URLQueryItem(name: "fb_bundle_version", value: "1.0"),
            URLQueryItem(name: "fb_bundle_short_version", value: "1")
        ]
        return components.url
    }
    
    public init() {}
    
}


public enum RoADeeplickType {
    case apsFlyer, FaceBook
}

