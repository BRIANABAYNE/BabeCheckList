//
//  Item.swift
//  BabeCheckList
//
//  Created by Briana Bayne on 2/24/24.
//

import Foundation


/// Encodable - A type that can encode itself to an external representation - has to be standard datatypes - String, Bools, Array 
/// Decode -
struct Item: Codable {
    
    var title: String = ""
    var done: Bool = false
    
}
