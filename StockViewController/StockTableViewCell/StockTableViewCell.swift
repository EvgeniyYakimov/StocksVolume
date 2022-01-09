//
//  StockTableViewCell.swift
//  StocksVolume
//
//  Created by Евгений on 01.12.2021.
//

import Foundation
import UIKit

class StockTableViewCell: UITableViewCell {
    
    var viewModel: StockTableViewCellProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.nameStock
            //content.secondaryText = 
            contentConfiguration = content
        }
    }
    
    
}
