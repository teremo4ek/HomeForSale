//
//  HomesInfoTableCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit

final class HomesInfoTableCoordinator: Coordinator {
    var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        let dataManager = DataManager.shared()
        let viewModel = HomesViewModel(dataManager: dataManager)
        let viewController = HomesViewController()
        viewController.viewModel = viewModel
        presentingController?.pushViewController(viewController, animated: true)
    }
}
