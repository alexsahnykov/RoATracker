//
//  CustomEvent.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 26/08/2019.
//

public struct Purchase: Eventable {
    public var id: Int
    public var eventName: String
    public var valueToSum: Double
    public var currency: String
    public var transactionId: Int?
    public var customParams: [String: Any]?
    
    public func converToParams() -> [String: Any]? {
        guard let transactionId = transactionId else {return nil}
        return [
            "eventName": eventName,
            "transactionId": transactionId
        ]
    }
    
    public init(id: Int, eventName: String, valueToSum: Double, currency: String) {
        self.id = id
        self.eventName = eventName
        self.valueToSum = valueToSum
        self.currency = currency
    }
    
    public init(id: Int, eventName: String, valueToSum: Double, currency: String, customParams: [String: Any]?) {
        self.id = id
        self.eventName = eventName
        self.valueToSum = valueToSum
        self.currency = currency
    }
    
    public init(transactionId: Int, id: Int, eventName: String, valueToSum: Double, currency: String) {
        self.init(id: id, eventName: eventName, valueToSum: valueToSum, currency: currency)
        self.transactionId = transactionId
    }
}
