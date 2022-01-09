//
//  StockViewModel.swift
//  StocksVolume
//
//  Created by Евгений on 30.11.2021.
//

import Foundation

protocol StockViewModelProtocol {

    var stocks: [Stock] {get set}
    
    func fetchStocks(comletion: @escaping() -> Void)
    func addStock(stockName: String)
    func deleteStock(at indexPath: IndexPath)
    func numberOfRow() -> Int
    func cellViewModel(at indexPath: IndexPath) -> StockTableViewCellProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> StockVolumeTableViewModelProtocol
    
}
    

class StockViewModel: StockViewModelProtocol {
    
    var stocks: [Stock] = []
    
    func fetchStocks(comletion: @escaping () -> Void) {
        CoreDataManager.shared.fetchData { stocks in
            self.stocks = stocks
        }
    }
    
    func addStock(stockName: String) {
        let stockData = Stock(symbol: stockName, volume: "")
        stocks.append(stockData)
        CoreDataManager.shared.saveStock(StokEnt: stockData)
    }
    
    func deleteStock(at indexPath: IndexPath) {
        let stockData = stocks[indexPath.row]
        CoreDataManager.shared.deleteStock(StokEnt: stockData)
        stocks.remove(at: indexPath.row)
    }
    
    func numberOfRow() -> Int {
        stocks.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> StockTableViewCellProtocol {
        let stock = stocks[indexPath.row]
        return StockTableViewCellViewModel(stock: stock)
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> StockVolumeTableViewModelProtocol {
        let stock = stocks[indexPath.row]
        return StockVolumeTableViewModel(stock: stock)
    }
    
}
