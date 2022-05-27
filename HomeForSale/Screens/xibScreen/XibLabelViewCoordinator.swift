//
//  XibLabelViewCoordinator.swift
//  HomeForSale
//
//  Created by Yury Bely on 19.05.2022.
//

import Foundation
import UIKit

final class XibLabelViewCoordinator: Coordinator {

    var presentingController: UINavigationController?

    init(presentingController: UINavigationController?) {
        self.presentingController = presentingController
    }

    func start() {
        let viewModel = LabelViewModel()
        let viewController = LabelViewController()
        viewController.viewModel = viewModel
        presentingController?.pushViewController(viewController, animated: true)
    }

}
