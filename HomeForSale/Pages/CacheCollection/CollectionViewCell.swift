//
//  CollectionViewCell.swift
//  HomeForSale
//
//  Created by Yury Bely on 02.06.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let minPadding: CGFloat = 8.0
    let smallPadding: CGFloat = 16.0

    var viewModel: CollectionCellViewModel? {
        didSet {
            viewModel?.delegate = self
            updateElements()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green

        contentView.addSubview(image)
        contentView.addSubview(likeButton)

        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var image: UIImageView = {
        let imageView = UIImageView(forAutoLayout: ())
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton(forAutoLayout: ())
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .red
        button.layer.cornerRadius = 16.0
        button.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        button.autoSetDimension(.width, toSize: 32.0)
        button.autoSetDimension(.height, toSize: 32.0)

        return button
    }()

    override func updateConstraints() {
        // print("CollectionViewCell: updateConstraints")
        image.autoPinEdgesToSuperviewEdges()

        likeButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: minPadding)
        likeButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: minPadding)

        super.updateConstraints()
    }

    private func updateElements() {
        image.image = viewModel?.largeImage ??  UIImage(systemName: "doc")
        likeButton.setImage(viewModel?.likeImage, for: .normal)

        setNeedsUpdateConstraints()
    }

    @objc func likeAction(sender: UIButton!) {
        viewModel?.likeAction()
    }
}

// MARK: extension NetworkDataDelegate
extension CollectionViewCell: NetworkDataDelegate {
    func onComplition() {

    }

    func onHomeInfoCellUpdated(indexPaths: [IndexPath]) {

    }

    func onImageDownloaded(id: String) {
        // print("CollectionViewCell.onImageDownloaded \(id)")
        DispatchQueue.main.async { [weak self] in
            self?.updateElements()
        }
    }

}
