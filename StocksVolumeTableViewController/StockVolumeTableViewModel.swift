//
//  StockVolumeTableViewModel.swift
//  StocksVolume
//
//  Created by Евгений on 03.12.2021.
//

import Foundation

enum FilterStockData {
    case hour
    case day
    case month
}

protocol StockVolumeTableViewModelProtocol {
    
    var stocks: [StockJson] {get}
    var selectStock: Stock {get set}
    func numberOfRow() -> Int
    func getDataWith(filter: FilterStockData, comletion: @escaping() -> ())
    func cellVolumeViewModel(at indexPath: IndexPath) -> VolumeStockTableViewCellProtocol
    init (stock: Stock)
}

class StockVolumeTableViewModel: StockVolumeTableViewModelProtocol {

    
    var selectStock: Stock
    var stocks: [StockJson] = []
    
    func getDataWith(filter: FilterStockData, comletion: @escaping () -> ()) {
        DataManager.shared.getVolumeDataWith(filter: filter, name: selectStock) { st in
            self.stocks = st
            comletion()
        }
    }
    
    func numberOfRow() -> Int {
        stocks.count
    }
    
    func cellVolumeViewModel(at indexPath: IndexPath) -> VolumeStockTableViewCellProtocol {
        let stock = stocks[indexPath.row]
        return VolumeStockTableViewCellModel(stock: stock)
    }
    
    required init(stock: Stock) {
        selectStock = stock
    }
    
}
