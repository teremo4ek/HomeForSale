//
//  TestCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 18.05.2022.
//

import Foundation
import UIKit

final class XibButtonViewCoordinator: Coordinator {

    var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        let viewModel = ButtonViewModel()
        let viewController = ButtonViewController()
        viewController.viewModel = viewModel
        presentingController?.pushViewController(viewController, animated: true)
    }

}
