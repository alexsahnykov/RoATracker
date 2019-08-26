//
//  RoAServerResponse.swift
//  FBSDKCoreKit
//
//  Created by Александр Сахнюков on 26/08/2019.
//

public struct RoAServerResponse: Decodable {
    
    let registredID: String?
    let error: RoAServerError?
    
    struct RoAServerError: Decodable {
        
        let id: Int?
        let describtion: String?
    
    }
}

public enum RoAServerError: Error {
    case wrondExtInfo
}

