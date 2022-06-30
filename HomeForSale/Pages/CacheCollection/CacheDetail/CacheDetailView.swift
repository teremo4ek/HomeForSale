//
//  CacheDetailView.swift
//  HomeForSale
//
//  Created by Yury Bely on 29.06.2022.
//

import Foundation
import UIKit

class CacheDetailView: UIView {

    let minPadding: CGFloat = 8.0
    let smallPadding: CGFloat = 16.0

    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let scrollView  = UIScrollView.newAutoLayout()
    private let contentView = UIView.newAutoLayout()

    var image: UIImageView = {
        let imageView = UIImageView(forAutoLayout: ())
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var idLabel: UILabel = {
        let label = UILabel(forAutoLayout: ())
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(forAutoLayout: ())
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .red
        button.layer.cornerRadius = 16.0
        button.autoSetDimension(.width, toSize: 32.0)
        button.autoSetDimension(.height, toSize: 32.0)
        return button
    }()

    private func addSubviews() {
        backgroundColor = .white

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(image)
        contentView.addSubview(idLabel)
        contentView.addSubview(likeButton)
    }

    private func setupConstraints() {
         scrollView.autoPinEdgesToSuperviewEdges()

         contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
         contentView.autoMatch(.width, to: .width, of: self)

        image.autoPinEdge(toSuperviewSafeArea: .top, withInset: smallPadding)
        image.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        image.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        image.autoSetDimension(.height, toSize: 250)

        idLabel.autoPinEdge(.top, to: .bottom, of: image, withOffset: smallPadding)
        idLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        idLabel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: smallPadding)

        likeButton.autoAlignAxis(.horizontal, toSameAxisOf: idLabel)
        likeButton.autoPinEdge(.leading, to: .trailing, of: idLabel, withOffset: minPadding)
        likeButton.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        // likeButton.setContentHuggingPriority(.defaultLow-1, for: .horizontal)

    }
}
