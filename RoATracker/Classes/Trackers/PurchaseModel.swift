//
//  PurchaseModel.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 26/08/2019.
//

public protocol Eventable {
    var eventName: String {get}
    var parameters: [String: Any]? {get}
}

public struct Event: Eventable {
    public var id: Int
    public var eventName: String
    public var parameters: [String: Any]?
    
    public init(_ id: Int, eventName: String, parameters: [String: Any]? = nil) {
        self.id = id
        self.eventName = eventName
        self.parameters = parameters
    }
    
}

