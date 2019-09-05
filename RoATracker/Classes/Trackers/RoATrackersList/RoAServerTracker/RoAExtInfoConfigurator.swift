//
//  RoAFaceExtInfoConfigurator.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 14/08/2019.
//

import CoreTelephony
import AdSupport

import Foundation
import CoreTelephony

struct RoAExtInfoConfigurator {
    
    private var extInfoParamets: [String] = []
    
    private var extInfoVer = "i2"
    
    lazy private var appPkgName: String = {
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
        uname(&systemInfo)
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
    
    private var screenSize: String = {
        let screen = UIScreen.main
        let within =  Int(screen.bounds.width)
        let height = Int(screen.bounds.height)
        let scale = String(format: "%.02f", screen.scale)
        print(scale)
        return [String(within), String(height), scale].joined(separator: ",")
    }()
    
    private var cpuCores = String(ProcessInfo.processInfo.processorCount)
    
    private var storageSize: String = {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        guard
            let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: documentDirectory),
            let freeSize = systemAttributes[.systemFreeSize] as? NSNumber,
            let totalSize = systemAttributes[.systemSize] as? NSNumber
            else {
                return ""
        }
        let total = Int(truncating: totalSize) / (1024 * 1024 * 1024)
        let free = Int(truncating: freeSize) / (1024 * 1024 * 1024)
        return String(total) + "," + String(free)
    }()
    
    private let timeZone = NSTimeZone.system.identifier
    
    public func getExtInfo() -> String {
        let getExtInfo = extInfoParamets.joined(separator: ",")
        testingPrint("[RoA Tracker server]: build extInfo \(getExtInfo)")
        return getExtInfo
    }
    
    public init() {
        let array:[String] = [extInfoVer, appPkgName, pkgVerCode, pkgInfoVerName, osVer, modelName, locale, devTimeZoneAbv, carrierName, screenSize, cpuCores, storageSize, timeZone]
        extInfoParamets = array
    }
}
