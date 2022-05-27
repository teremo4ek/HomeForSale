//
//  HomeDetailViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import UIKit

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

            self?.homeDetailView.houseImage.image = UIImage(named: "houseImg")
            self?.homeDetailView.addressLabel.text = self?.viewModel.homeDetail?.streetAddress
            self?.homeDetailView.municipalityAreaLabel.text = String("\(self?.viewModel.homeDetail?.area), \(self?.viewModel.homeDetail?.municipality)" )
            self?.homeDetailView.askingPriceLabel.text = String(self?.viewModel.homeDetail?.askingPrice ?? 0)
            self?.homeDetailView.homeDescriptionLabel.text = self?.viewModel.homeDetail?.homeDescription
            self?.homeDetailView.livingAreaLabel.text = String(self?.viewModel.homeDetail?.livingArea ?? 0)
            self?.homeDetailView.numberOfRoomsLabel.text = String(self?.viewModel.homeDetail?.numberOfRooms ?? 0)
            self?.homeDetailView.patioLabel.text = self?.viewModel.homeDetail?.patio
            self?.homeDetailView.daysSincePublishLabel.text = String(self?.viewModel.homeDetail?.daysSincePublish ?? 0)

        }
    }

}

extension HomeDetailViewController: NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

}
