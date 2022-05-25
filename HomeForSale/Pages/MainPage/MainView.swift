//
//  MainView.swift
//  HomeForSale
//
//  Created by Yury Bely on 23.05.2022.
//

import UIKit
import PureLayout

class MainView: UIView {

    lazy var buttonPureLayout: UIButton = {
        let button = UIButton()
        button.setTitle("PureLayout", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.cornerRadius = 4.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.tintColor = .gray
        button.backgroundColor = .clear
        button.autoSetDimension(.width, toSize: 120.0)
        button.autoSetDimension(.height, toSize: 32.0)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private func
    
    private func addSubviews() {
        addSubview(buttonPureLayout)
    }
    
    func setupConstraints() {
        buttonPureLayout.autoAlignAxis(toSuperviewAxis: .vertical)
        buttonPureLayout.autoPinEdge(toSuperviewEdge: .top, withInset: 200.0)
    }
}
