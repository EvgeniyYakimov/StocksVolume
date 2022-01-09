//
//  StockVolumeTableViewController.swift
//  StocksVolume
//
//  Created by Евгений on 01.12.2021.
//

import UIKit

class StockVolumeTableViewController: UITableViewController {

   var viewModel: StockVolumeTableViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.selectStock.symbol
    }
    
    
    @IBAction func getVolume(_ sender: Any) {
        displayAlertMenu()
    }
    
    
    func displayAlertMenu() {

        let alert = UIAlertController(title: "Выбирите вид", message: nil, preferredStyle: .actionSheet)

        let hourVolume = UIAlertAction(title: "Объемы за час", style: .default) {
            action in
            self.viewModel.getDataWith(filter: FilterStockData.hour) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let dayVolume = UIAlertAction(title: "Объемы за день", style: .default) {
            action in
            self.viewModel.getDataWith(filter: FilterStockData.day) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

        
        let monthVolume = UIAlertAction(title: "Объемы за месяц", style: .default) {
            action in
            self.viewModel.getDataWith(filter: FilterStockData.month) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel) {
            action in
            print("user tapped the cancel button")
        }

        alert.addAction(hourVolume)
        alert.addAction(dayVolume)
        alert.addAction(monthVolume)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VolumeStockTableViewCell {
            cell.viewModel = viewModel.cellVolumeViewModel(at: indexPath)
            return cell
        } else {
           return UITableViewCell()
        }
    }

}


