//
//  PurchaseModel.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 26/08/2019.
//

public protocol Eventable {
    var id: Int {get}
    var eventName: String {get}
}

public struct Event: Eventable {
    public var id: Int
    public var eventName: String
    
    public init(id: Int, eventName: String) {
        self.id = id
        self.eventName = eventName
    }
}

