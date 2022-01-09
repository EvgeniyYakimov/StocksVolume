//
//  VolumeStockTableViewCell.swift
//  StocksVolume
//
//  Created by Евгений on 03.12.2021.
//

import Foundation
import UIKit

class VolumeStockTableViewCell: UITableViewCell {
    
    var viewModel: VolumeStockTableViewCellProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.periodName
            content.secondaryText = viewModel.volume
            contentConfiguration = content
        }
    }
    
    
}
