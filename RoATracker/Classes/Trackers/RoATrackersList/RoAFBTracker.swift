//
//  RoAFBTracker.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//
import FBSDKCoreKit

public class RoAFBTracker : RoATracker {
    
    public func install() {
        
    }
    
    func setupFBDelegate(_ aplication: UIApplication, open: URL, options: [UIApplication.OpenURLOptionsKey : Any]) {
        ApplicationDelegate.shared.application(aplication, open: open, options: options)
    }
    
    func setupFBDelegate(_ aplication: UIApplication, options: [UIApplication.LaunchOptionsKey : Any]?) {
        ApplicationDelegate.shared.application(aplication, didFinishLaunchingWithOptions: options)
    }
    
    
    init() {
        
    }
    
}
