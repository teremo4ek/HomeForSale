//
//  MainTableViewModel.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import Foundation

class MainTableViewModel : MainTableViewModelType {
    private var selectedIndexPath: IndexPath?
    
    var profiles = [
        Profile(name: "John", secondName: "Smith", age: 33),
        Profile(name: "Max", secondName: "Kolby", age: 21),
        Profile(name: "Mark", secondName: "Salmon", age: 55)
    ]
    
    func numberOfRows() -> Int {
        return profiles.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> HomeViewCellViewModelType? {
        let profile = profiles[indexPath.row]
        return HomeViewCellViewModel(profile: profile)
    }
    
    func viewModelForSelectedRow() -> HomeDetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return HomeDetailViewModel(profile: profiles[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
