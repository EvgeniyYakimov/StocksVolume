//
//  CoreDataManager.swift
//  StocksVolume
//
//  Created by Евгений on 09.11.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let contect = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var masStocks : [StockData] = []
    var returnStocks : [Stock] = []
    
    func saveStock(StokEnt: Stock)  {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "StockData", in: contect) else {return}
        guard let stock = NSManagedObject(entity: entityDescription, insertInto: contect) as? StockData  else {return}
        stock.symbolData = StokEnt.symbol
        
        if contect.hasChanges {
          do {
             try contect.save()
          } catch let error {
             print(error)
          }
        }
        
    }
    
    func deleteStock(StokEnt: Stock)  {
        let fetchRequest: NSFetchRequest<StockData> = StockData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "symbolData == %@", StokEnt.symbol!)
        
        do {
            masStocks =  try contect.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        if masStocks.count > 0 {
          for i in masStocks {
            contect.delete(i)
          }
        }
        
        if contect.hasChanges {
          do {
             try contect.save()
          } catch let error {
             print(error)
          }
        }
        
    }
    
    func fetchData(comletion: @escaping([Stock]) -> Void) {
        let fetchRequest: NSFetchRequest<StockData> = StockData.fetchRequest()
        
        do {
            masStocks =  try contect.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        
        if masStocks.count > 0 {
            for i in masStocks {
                returnStocks.append(Stock(symbol: i.symbolData, volume: ""))
            }
        }
        
        comletion(returnStocks)
    }
    
    
    
}
