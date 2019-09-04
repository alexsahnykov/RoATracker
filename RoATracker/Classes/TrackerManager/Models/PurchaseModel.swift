//
//  PurchaseModel.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 26/08/2019.
//

import StoreKit

public struct Purchase: Eventable {
    
    public var eventName: String
    public var valueToSum: Double
    public var currency: String
    public var transactionId: Int?
    public var parameters: [String: Any]?
    
    public func converToParams() -> [String: Any]? {
        guard let transactionId = transactionId else {return nil}
        return [
            "eventName": eventName,
            "transactionId": transactionId
        ]
    }
    
    public init(eventName: String, valueToSum: Double, currency: String, customParams: [String: Any]? = nil) {
        
        self.eventName = eventName
        self.valueToSum = valueToSum
        self.currency = currency
        self.parameters = customParams
    }
    
    public init(transactionId: Int, eventName: String, valueToSum: Double, currency: String) {
        self.init(eventName: eventName, valueToSum: valueToSum, currency: currency)
        self.transactionId = transactionId
    }
    
    public init(_ product: SKProduct) {
        let name = product.productIdentifier
        let sum = product.price
        let currency = product.localizedPrice
        self.init(eventName: name, valueToSum: Double(truncating: sum), currency: currency)
    }
    
    public init(product: SKProduct, customParams: [String: Any]? = nil) {
         self.init(product)
         self.parameters = customParams
    }
    
    private func priceStringFor(_ product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
    }
}


