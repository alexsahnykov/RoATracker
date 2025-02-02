//
//  TrackerProtocol.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATracker: UIApplicationDelegate {
    
    func install()
    
    func purchase()
    
    func registerTracker(_ deeplink: NSURL?)
    
    func createEvent(_ eventNmae: String)
    
}

