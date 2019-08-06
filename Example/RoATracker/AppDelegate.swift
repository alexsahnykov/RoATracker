//
//  AppDelegate.swift
//  RoATracker
//
//  Created by alexSahnykov on 07/31/2019.
//  Copyright (c) 2019 alexSahnykov. All rights reserved.
//

import UIKit
import RoATracker


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let _ = RoATrackerManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        RoATrackerManager.shared.get(RoAFBTracker.self)?.install()
        RoATrackerManager.shared.get(RoAServerTracker.self)?.install()
        RoATrackerManager.shared.getID()
        return true
    }


    override init() {
        let manager = RoAFBTracker()
        RoATrackerManager.shared.add(manager)
    }
}

