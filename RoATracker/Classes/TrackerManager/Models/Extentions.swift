//
//  Extentions.swift
//  Bolts
//
//  Created by Александр Сахнюков on 01/08/2019.
//

extension Array {
    mutating func remove(_ object: AnyObject) {
        if let index = firstIndex(where: { $0 as AnyObject === object }) {
            remove(at: index)
        }
    }
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}

public func testingPrint(_ object: Any) {
    #if DEBUG
    print(object)
    #endif
}
