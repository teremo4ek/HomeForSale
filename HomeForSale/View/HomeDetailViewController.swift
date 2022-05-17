//
//  HomeDetailControllerViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 14.05.2022.
//

import UIKit

class HomeDetailViewController: UIViewController {
    
    var viewModel: HomeDetailViewModelType?

    @IBOutlet private weak var askingPrice: UILabel!
    @IBOutlet private weak var municipalityArea: UILabel!
    @IBOutlet private weak var daysSincePublish: UILabel!
    @IBOutlet private weak var livingArea: UILabel!
    @IBOutlet private weak var numberOfRooms: UILabel!
    @IBOutlet private weak var streetAddress: UILabel!
    @IBOutlet private weak var image: UILabel!
    @IBOutlet private weak var homeDescription: UILabel!
    @IBOutlet private weak var patio: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewModel = viewModel else { return }
        print("HomeDetailViewController viewWillAppear ")
        
        askingPrice.text = String(viewModel.askingPrice)
        municipalityArea.text = viewModel.municipalityArea
        daysSincePublish.text = String(viewModel.daysSincePublish)
        livingArea.text = String(viewModel.livingArea)
        numberOfRooms.text = String(viewModel.numberOfRooms)
        streetAddress.text = viewModel.streetAddress
        //image.text = viewModel.image
        homeDescription.text = viewModel.description
        patio.text = viewModel.patio

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewModel?.age.bind { [unowned self] in
        //    guard let string = $0 else { return }
        //    self.textLabel.text = string
        //}
        
        //delay(delay: 5) { [unowned self] in
        //    self.viewModel?.age.value = "some new value"
        //}
    }
    
    //private func delay(delay: Double, closure: @escaping () -> ()) {
    //    DispatchQueue.main.asyncAfter(wallDeadline: .now() + delay) {
    //        closure()
    //    }
    //}

}
