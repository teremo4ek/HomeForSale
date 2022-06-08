//
//  MainController.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class MainController: UIViewController {

    private let mainView = MainView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Main Page"
        self.view.backgroundColor = .white
        self.view.addSubview(self.mainView)
        self.mainView.autoPinEdgesToSuperviewEdges()
        self.view.layoutIfNeeded()

        self.mainView.buttonPureLayout.addTarget(self, action: #selector(pureLayoutAction), for: .touchUpInside)

        self.mainView.buttonCache.addTarget(self, action: #selector(cacheAction), for: .touchUpInside)
    }

    @objc func pureLayoutAction(sender: UIButton!) {
        print("btnPureLayoutAction")
        let coordinator = HomesInfoTableCoordinator(presentingController: navigationController)
        coordinator.start()
    }

    @objc func cacheAction(sender: UIButton!) {
        print("btnCacheAction")
        let coordinator = CacheCollectionCoordinator(presentingController: navigationController)
        coordinator.start()
    }
}
