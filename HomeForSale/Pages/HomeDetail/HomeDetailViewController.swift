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
    
    // MARK -- Update Interface
    private func updateInterface() {
        print("HomeDetailViewController - updateInterface()")
        
        homeDetailView.houseImage.image = UIImage(named: "houseImg")
        homeDetailView.addressLabel.text = viewModel.homeDetail?.streetAddress
        homeDetailView.municipalityAreaLabel.text = String("\(viewModel.homeDetail?.area), \(viewModel.homeDetail?.municipality)" )
        homeDetailView.askingPriceLabel.text = String(viewModel.homeDetail?.askingPrice ?? 0)
        homeDetailView.homeDescriptionLabel.text = viewModel.homeDetail?.homeDescription
        homeDetailView.livingAreaLabel.text = String(viewModel.homeDetail?.livingArea ?? 0)
        homeDetailView.numberOfRoomsLabel.text = String(viewModel.homeDetail?.numberOfRooms ?? 0)
        homeDetailView.patioLabel.text = viewModel.homeDetail?.patio
        homeDetailView.daysSincePublishLabel.text = String(viewModel.homeDetail?.daysSincePublish ?? 0)
    }
        
}

extension HomeDetailViewController : NetworkDataDelegate {
    func onComplition() {
        self.updateInterface()
    }

}
