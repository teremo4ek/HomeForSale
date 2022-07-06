//
//  CacheCollectionCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import Foundation
import UIKit

final class CacheCollectionCoordinator: Coordinator {
    private var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        presentingController?.pushViewController(viewController(), animated: true)
    }

    func viewController() -> UIViewController {
        let dataManager = DataManager.shared()
        let viewModel = CacheCollectionViewModel(dataManager: dataManager)
        let viewController = CacheCollectionViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
