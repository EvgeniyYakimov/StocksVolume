//
//  ViewController.swift
//  StocksVolume
//
//  Created by Евгений on 26.10.2021.
//

import UIKit

class ViewController: UIViewController, SelectedStock {
    
    private var viewModel: StockViewModelProtocol! {
        didSet {
            viewModel.fetchStocks {
                self.stockTable.reloadData()
            }
        }
    }
    
    @IBOutlet weak var stockTable: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = StockViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "getStock" {
            guard let destination = segue.destination as? SearchViewController else { return }
            destination.delegateStock = self
        }
        else if segue.identifier == "volumeSeg" {
            guard let destination = segue.destination as? StockVolumeTableViewController else { return }
            destination.viewModel = sender as? StockVolumeTableViewModelProtocol
        }
    }
    
    
    func didDelectStock(result: String) {
        viewModel.addStock(stockName: result)
        stockTable.reloadData()
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? StockTableViewCell {
            cell.viewModel = viewModel.cellViewModel(at: indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
        let volumeStockTable = viewModel.viewModelForSelectedRow(at: indexPath)
        performSegue(withIdentifier: "volumeSeg", sender: volumeStockTable)        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewModel.deleteStock(at: indexPath)
            tableView.endUpdates()
        }
        
    }
    
}

