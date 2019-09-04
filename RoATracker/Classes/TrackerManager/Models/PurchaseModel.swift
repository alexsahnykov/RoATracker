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
    public var transactionId: Int
    public var parameters: [String: Any]?
    
    public init(_ transactionId: Int, eventName: String, valueToSum: Double, currency: String, customParams: [String: Any]? = nil) {
        self.eventName = eventName
        self.valueToSum = valueToSum
        self.currency = currency
        self.parameters = customParams
        self.transactionId = transactionId
    }

    
    public init(_ transactionId: Int, product: SKProduct, customParams: [String: Any]? = nil) {
        let name = product.productIdentifier
        let sum = product.price
        let currency = product.localizedPrice
        self.init(transactionId, eventName: name, valueToSum: Double(truncating: sum), currency: currency, customParams: customParams)
    }

    
    private func priceStringFor(_ product: SKProduct) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currencyISOCode
        numberFormatter.locale = product.priceLocale
        return numberFormatter.string(from: product.price)!
    }
    
    
}


//let locale = Locale.current
//let currencySymbol = locale.currencySymbol!
//let currencyCode = locale.currencyCode!
