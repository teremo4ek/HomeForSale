//
//  LabelViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 19.05.2022.
//

import UIKit

class LabelViewController: UIViewController {

    var viewModel: LabelViewModel!

    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var okButton: UIButton!
    @IBOutlet private(set) weak var slider: UISlider!

    @IBAction private func okPressed() {
        titleLabel.text = "Button pressed!"
    }

    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        titleLabel.text = String(format: "Slider %.1f", sender.value)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
    }

    private func bind() {
        titleLabel.text = viewModel.title
        okButton.setTitle(viewModel.okBtnTitle, for: .normal)
        slider.minimumValue = 0
        slider.maximumValue = 10
    }
}
