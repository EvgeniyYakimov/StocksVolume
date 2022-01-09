//
//  StockTableViewCelViewModel.swift
//  StocksVolume
//
//  Created by Евгений on 01.12.2021.
//

import Foundation

protocol StockTableViewCellProtocol {
    var nameStock: String {get}
    
    init(stock: Stock)

}

class StockTableViewCellViewModel: StockTableViewCellProtocol {
    var nameStock: String {
        stock.symbol!
    }
    
    var stock: Stock
    
    required init(stock: Stock) {
        self.stock = stock
    }

}
