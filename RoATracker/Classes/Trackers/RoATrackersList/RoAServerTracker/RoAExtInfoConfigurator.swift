//
//  RoAFaceExtInfoConfigurator.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 14/08/2019.
//

import Foundation
import CoreTelephony

public struct RoAExtInfoConfigurator {
    
    private var extInfoParamets: [String] = []
    
    private var extInfoVer = "i2"
    
    private var appPkgName: String = {
        guard let bundle = Bundle.main.bundleIdentifier else { return "noBundle"}
        return bundle
    }()
    
    private var pkgVerCode: String = {
        guard let code = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return "noVerCode"}
        return code
    }()
    
    private var pkgInfoVerName: String = {
        guard let code = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "noVerCodeName"}
        return code
    }()
    
    private var osVer = UIDevice.current.systemVersion
    
    private let modelName: String = {
        var systemInfo = utsname()
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()
    
    private var locale = Locale.current.identifier
    
    private var devTimeZoneAbv: String = {
        guard let timezoe = TimeZone.current.abbreviation() else { return "NoTime"}
        return timezoe
    }()
    
    private var carrierName: String = {
        let networkInfo = CTTelephonyNetworkInfo.init()
        guard let carrier = networkInfo.subscriberCellularProvider?.carrierName else { return "NoCarrier"}
        return carrier
    }()
    
    
    private let timeZone = NSTimeZone.system.identifier
    
    public func getExtInfo() -> String {
        return extInfoParamets.joined(separator: ",")
    }
    
    init() {
        let array:[String] = [extInfoVer, appPkgName, pkgVerCode, pkgInfoVerName, osVer, modelName, locale, devTimeZoneAbv, carrierName]
        extInfoParamets = array
    }
    
    
    
}
