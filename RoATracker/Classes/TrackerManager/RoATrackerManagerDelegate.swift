//
//  RoATrackerManagerDelegate.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 03/09/2019.
//

public protocol RoATrackerManagerDelegate: class {
    
    func getDeeplink(_ type: DeeplinkType, deeplink: [AnyHashable: Any])
}
