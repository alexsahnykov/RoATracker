//
//  TrackerProtocol.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 01/08/2019.
//

public protocol RoATracker: UIApplicationDelegate {
    
    var delegate: RoATrackerManagerDelegate? {get set}
    
    func install()
    
    func purchase(_ purchase: Purchase)
    
    func customEvent(_ event: Eventable)
    
    func trial(_ event: Eventable)
    
}

