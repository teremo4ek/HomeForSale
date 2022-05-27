//
//  TestViewController.swift
//  HomeForSale
//
//  Created by Yury Bely on 18.05.2022.
//

import UIKit

final class ButtonViewController: UIViewController {

    var _view: ButtonView { view as! ButtonView }
    var viewModel: ButtonViewModel!

    override func loadView() {
        let contentView = Bundle.main.loadNibNamed("ButtonView", owner: self, options: nil)?.first as! UIView
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray

        bind()
    }

    private func bind() {
        _view.titleLabel.text = viewModel.title
        _view.okButton.setTitle(viewModel.okBtnTitle, for: .normal)
        _view.onOkAction = { print("Pressed btn - screen action") }
    }

}
