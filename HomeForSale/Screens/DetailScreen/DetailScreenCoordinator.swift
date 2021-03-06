//
//  DetailScreenCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 19.05.2022.
//

import Foundation
import UIKit

final class DetailScreenCoordinator: Coordinator {
    var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        presentingController?.pushViewController(viewController(), animated: true)
    }

    func viewController() -> UIViewController {
        let viewModel = DetailScreenViewModel()
        let viewController = DetailScreenViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
