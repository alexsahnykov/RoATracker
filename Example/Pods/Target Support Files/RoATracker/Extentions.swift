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
