//
//  PageIntroView.swift
//  HomeForSale
//
//  Created by Yury Bely on 07.07.2022.
//

import UIKit
import PureLayout

class PageIntroView: UIView {

    init() {
        super.init(frame: .zero)

        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Image
    let pageImage: UIImageView = {
       let view = UIImageView(forAutoLayout: ())
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()

    // MARK: - Label
    let nameLabel: UILabel = {
       let label = UILabel(forAutoLayout: ())
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    // MARK: - Sub Label
    let subLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        return label
    }()

    private func addSubviews() {
        addSubview(pageImage)
        addSubview(nameLabel)
        addSubview(subLabel)
    }

    private func setupConstraints() {

        pageImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: 100)
        pageImage.autoAlignAxis(toSuperviewAxis: .vertical)

        nameLabel.autoPinEdge(.top, to: .bottom, of: pageImage, withOffset: 50)
        nameLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        subLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 20)
        subLabel.autoAlignAxis(toSuperviewAxis: .vertical)

    }

}
