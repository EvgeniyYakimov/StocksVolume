//
//  DataManager.swift
//  StocksVolume
//
//  Created by Евгений on 26.10.2021.
//

import Foundation

class DataManager {
    
    private let urlStockForKey = "https://financialmodelingprep.com/api/v3/financial-statement-symbol-lists?apikey=09605e331e1e6c998270160aaadb547a"
    
    private let urlStockVolumeHour = "https://financialmodelingprep.com/api/v3/historical-chart/1min/symbol?limit=27&apikey=09605e331e1e6c998270160aaadb547a"
    
    private let urlStockVolumeDay = "https://financialmodelingprep.com/api/v3/historical-chart/1hour/symbol?apikey=09605e331e1e6c998270160aaadb547a"
    
    private let urlStockVolumeMonth = "https://financialmodelingprep.com/api/v3/historical-price-full/symbol?limit=27&apikey=09605e331e1e6c998270160aaadb547a"
    
    static let shared = DataManager()
    
    private var newURl = ""
    private var st : [String] = []
    private var dataSt: [StockJson] = []
    
    func getVolumeDataWith(filter: FilterStockData, name: Stock, stocks: @escaping ((_ stoks: [StockJson]) -> ()))  {
    
        switch filter {
        case .hour:
            newURl = urlStockVolumeHour.replacingOccurrences(of: "symbol", with: name.symbol!)
            getVolumeDataWithHour(name: name, url: newURl) { st in
                stocks(st)
            }
        case .day:
            newURl = urlStockVolumeDay.replacingOccurrences(of: "symbol", with: name.symbol!)
            getVolumeDataWithDay(name: name, url: newURl) { st in
                stocks(st)
            }
        case .month:
            newURl = urlStockVolumeMonth.replacingOccurrences(of: "symbol", with: name.symbol!)
            getVolumeDataWithMonth(name: name, url: newURl) { st in
                stocks(st)
            }
        }
    
    }
    
    private func getStocks(masOfStocks: @escaping((_ stoks: [String]) -> ())) {
        guard let urlSt = URL(string: urlStockForKey) else { return}
        URLSession.shared.dataTask(with: urlSt) { data, response, error in
           
            guard let data = data else {return}
            guard error ==  nil else {return}
            
            do {
                self.st =  try JSONDecoder().decode([String].self, from: data)
                masOfStocks(self.st)
            
                    } catch let error {
                        print(error.localizedDescription)
                    }
            
            }.resume()
    }
    
    func getForKey(for key: String, Stocks: @escaping((_ stoks: [String]) -> ())) {
        if st.count == 0 {
            getStocks() { stks in
                Stocks(self.st.filter({$0.prefix(key.count).uppercased() == key.uppercased()}))
            }
        }
        else {
            Stocks(self.st.filter({$0.prefix(key.count).uppercased() == key.uppercased()}))
        }
    }
    
   private func getVolumeDataWithHour(name: Stock, url: String, stocks: @escaping ((_ stoks: [StockJson]) -> ()))  {
        
        guard let urlSt = URL(string: url) else { return}
        URLSession.shared.dataTask(with: urlSt) { data, response, error in
           
            guard let data = data else {return}
            guard error ==  nil else {return}
            
            do {
                self.dataSt =  try JSONDecoder().decode([StockJson].self, from: data)
                stocks(self.dataSt)
            
                    } catch let error {
                        print(error.localizedDescription)
                    }
            
            }.resume()
    }
    
    private func getVolumeDataWithMonth(name: Stock, url: String, stocks: @escaping ((_ stoks: [StockJson]) -> ()))  {
        
        guard let urlSt = URL(string: url) else { return}
        URLSession.shared.dataTask(with: urlSt) { data, response, error in
           
            guard let data = data else {return}
            guard error ==  nil else {return}
            
            do {
                let tempSt = try JSONDecoder().decode(HistoricalStockJson.self, from: data)
                self.dataSt =  tempSt.historical!
                stocks(self.dataSt)
            
                    } catch let error {
                        print(error.localizedDescription)
                    }
            
            }.resume()
    }
    
    
    private func getVolumeDataWithDay(name: Stock, url: String, stocks: @escaping ((_ stoks: [StockJson]) -> ()))  {
        
        guard let urlSt = URL(string: url) else { return}
        URLSession.shared.dataTask(with: urlSt) { data, response, error in
           
            guard let data = data else {return}
            guard error ==  nil else {return}
            
            do {
                self.dataSt =  try JSONDecoder().decode([StockJson].self, from: data)
                stocks(self.dataSt)
            
                    } catch let error {
                        print(error.localizedDescription)
                    }
            
            }.resume()
    }
    
}
