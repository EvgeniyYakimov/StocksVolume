//
//  VolumeStockTableViewCellModel.swift
//  StocksVolume
//
//  Created by Евгений on 03.12.2021.
//

import Foundation

protocol VolumeStockTableViewCellProtocol {
    
    var periodName: String {get}
    var volume: String {get}
    
    init(stock: StockJson)

}

class VolumeStockTableViewCellModel: VolumeStockTableViewCellProtocol {
    var periodName: String {
        stock.date!
    }
    var volume: String {
        String(describing: stock.volume!)
    }
    
    var stock: StockJson
    
    required init(stock: StockJson) {
        self.stock = stock
    }

}
