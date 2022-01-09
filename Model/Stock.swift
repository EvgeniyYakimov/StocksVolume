//
//  Stock.swift
//  StocksVolume
//
//  Created by Евгений on 26.10.2021.
//

import Foundation

struct Stock : Decodable {
    let symbol: String?
    let volume: String?
   // let name: String?
    
//    enum CodingKeys: String, CodingKey {
//        case symbol = "1. symbol"
//        case name = "2. name"
//    }
//
}

struct DataStocks:Decodable {
    let bestMatches: [Stock]?
}


