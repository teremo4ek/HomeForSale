//
//  HomeDetailViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import UIKit
import SDWebImage

class HomeDetailViewController: UIViewController {

    var viewModel: HomeDetailViewModel!

    var homeDetailView: HomeDetailView {
        view as! HomeDetailView
    }

    override func loadView() {
        view = HomeDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel?.fetchData()
    }

    // MARK: - - Update Interface
    private func updateInterface() {

        DispatchQueue.main.async { [weak self] in
            print("HomeDetailViewController - updateInterface()")
            guard let self = self else { return }

            self.homeDetailView.houseImage.sd_setImage(with: URL(string: self.viewModel.imageUrl))
            self.homeDetailView.addressLabel.text = self.viewModel.streetAddress
            self.homeDetailView.municipalityAreaLabel.text = self.viewModel.homeDescription
            self.homeDetailView.askingPriceLabel.text = String(self.viewModel.askingPrice)
            self.homeDetailView.homeDescriptionLabel.text = self.viewModel.homeDescription
            self.homeDetailView.livingAreaLabel.text = String(self.viewModel.livingArea)
            self.homeDetailView.numberOfRoomsLabel.text = String(self.viewModel.numberOfRooms)
            self.homeDetailView.patioLabel.text = self.viewModel.patio
            self.homeDetailView.daysSincePublishLabel.text = String(self.viewModel.daysSincePublish)

        }
    }

}

extension HomeDetailViewController: NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

    func onHomeInfoCellUpdated(indexes: [Int]) {

    }
}
