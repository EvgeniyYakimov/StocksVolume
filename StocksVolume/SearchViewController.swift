//
//  SearchViewController.swift
//  StocksVolume
//
//  Created by Евгений on 27.10.2021.
//

import UIKit

protocol SelectedStock : AnyObject {
    func didDelectStock(result: String)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var keySearchBar: UISearchBar!
    @IBOutlet weak var stoksTableView: UITableView!
    
    var stocks: [String] = []
    weak var delegateStock: SelectedStock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keySearchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellStock") {
            cell.textLabel?.text = stocks[indexPath.row]
            return cell
        } else {
           return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateStock?.didDelectStock(result: stocks[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DataManager.shared.getForKey(for: searchText) { st in
            self.stocks = st
            DispatchQueue.main.async {
                self.stoksTableView.reloadData()
            }
        }
    }
}
