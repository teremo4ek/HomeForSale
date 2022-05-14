//
//  MainTableViewModelType.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

protocol MainTableViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeViewCellViewModelType?
    
    func viewModelForSelectedRow() -> HomeDetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
}
