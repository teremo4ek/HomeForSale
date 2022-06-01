//
//  TestView.swift
//  HomeForSale
//
//  Created by Yury Bely on 18.05.2022.
//

import Foundation
import UIKit

final class ButtonView: UIView {
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var okButton: UIButton!

    var onOkAction: (() -> Void)?
    @IBAction private func okPressed() {
        onOkAction?()
    }
}
