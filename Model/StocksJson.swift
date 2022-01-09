//
//  StocksData.swift
//  StocksJson
//
//  Created by Евгений on 03.12.2021.
//

import Foundation

struct StockJson : Decodable {
    let date: String?
    let open: Double?
    let low: Double?
    let high: Double?
    let close: Double?
    let volume: Int?
}

struct HistoricalStockJson: Decodable {
    let symbol: String?
    let historical:[StockJson]?
}


