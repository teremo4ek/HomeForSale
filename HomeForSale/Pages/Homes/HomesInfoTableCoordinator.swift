//
//  HomesInfoTableCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit

final class HomesInfoTableCoordinator: Coordinator {

    private var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        presentingController?.pushViewController(viewController(), animated: true)
    }

    func viewController() -> UIViewController {
        let dataManager = DataManager.shared()
        let viewModel = HomesViewModel(dataManager: dataManager)
        let viewController = HomesViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
