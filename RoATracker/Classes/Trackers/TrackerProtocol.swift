//
//  TrackerProtocol.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATracker: UIApplicationDelegate {
    
    func install()
    
    func purchase(_ purchase: Purchase)
    
    func registerTracker(_ deeplink: String?)
    
    func createEvent(_ event: Eventable)
    
}

