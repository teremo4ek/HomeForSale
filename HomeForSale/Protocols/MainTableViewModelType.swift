//
//  MainTableViewModelType.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

protocol MainTableViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeCellViewModelType?
    
    func viewModelForSelectedRow() -> HomeDetailViewModelType?
    func selectRow(atIndexPath indexPath: IndexPath)
    
    // data throw network
    func fetchData()
}

protocol MainTableNetworkDataDelegate : AnyObject {
    func onComplition()
}

protocol NetworkDataDelegate : AnyObject {
    func onComplition()
}
