//
//  HomeDetailCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import Foundation
import UIKit

final class HomeDetailCoordinator: Coordinator {
    var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        let dataManager = DataManager.shared()
        let viewModel = HomeDetailViewModel(dataManager: dataManager)
        let viewController = HomeDetailViewController()
        viewController.viewModel = viewModel
        presentingController?.pushViewController(viewController, animated: true)
    }
}
