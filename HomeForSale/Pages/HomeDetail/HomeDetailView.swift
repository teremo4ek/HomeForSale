//
//  HomeDetailView.swift
//  HomeForSale
//
//  Created by Yury Bely on 25.05.2022.
//

import Foundation
import UIKit

class HomeDetailView: UIView {

    private let minPadding: CGFloat = 4.0
    private let smallPadding: CGFloat = 16.0
    private let midlePadding: CGFloat = 24.0
    
    private let scrollView  = UIScrollView.newAutoLayout()
    private let contentView = UIView.newAutoLayout()
    
    var houseImage: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    var addressLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    var municipalityAreaLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.textColor = .gray
        return label
    }()
    
    var askingPriceLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var homeDescriptionLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.numberOfLines = 0
        return label
    }()
    
    var livingAreaTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var livingAreaLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var numberOfRoomsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var numberOfRoomsTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var patioLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var patioTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    var daysSincePublishLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var daysSincePublishTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    //MARK: init
    init() {
        super.init(frame: .zero)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(houseImage)
        contentView.addSubview(addressLabel)
        contentView.addSubview(municipalityAreaLabel)
        contentView.addSubview(askingPriceLabel)
        contentView.addSubview(homeDescriptionLabel)
        contentView.addSubview(livingAreaTitel)
        contentView.addSubview(livingAreaLabel)
        contentView.addSubview(numberOfRoomsLabel)
        contentView.addSubview(numberOfRoomsTitel)
        contentView.addSubview(patioLabel)
        contentView.addSubview(patioTitel)
        contentView.addSubview(daysSincePublishLabel)
        contentView.addSubview(daysSincePublishTitel)
    }
    
    private func setupConstraints() {
        scrollView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        
        contentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero)
        contentView.autoMatch(.width, to: .width, of: self)
        
        houseImage.autoPinEdge(toSuperviewEdge: .top, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        houseImage.autoSetDimension(.height, toSize: 250)
        
        addressLabel.autoPinEdge(.top, to: .bottom, of: houseImage, withOffset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        municipalityAreaLabel.autoPinEdge(.top, to: .bottom, of: addressLabel, withOffset: minPadding)
        municipalityAreaLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        municipalityAreaLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        askingPriceLabel.autoPinEdge(.top, to: .bottom, of: municipalityAreaLabel, withOffset: minPadding)
        askingPriceLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        askingPriceLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        homeDescriptionLabel.autoPinEdge(.top, to: .bottom, of: askingPriceLabel, withOffset: smallPadding)
        homeDescriptionLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        homeDescriptionLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)

        livingAreaTitel.autoPinEdge(.top, to: .bottom, of: homeDescriptionLabel, withOffset: midlePadding)
        livingAreaTitel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        
        livingAreaLabel.autoAlignAxis(.horizontal, toSameAxisOf: livingAreaTitel)
        livingAreaLabel.autoPinEdge(.leading, to: .trailing, of: livingAreaTitel, withOffset: minPadding)
        livingAreaLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        numberOfRoomsTitel.autoPinEdge(.top, to: .bottom, of: livingAreaLabel, withOffset: minPadding)
        numberOfRoomsTitel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        
        numberOfRoomsLabel.autoAlignAxis(.horizontal, toSameAxisOf: numberOfRoomsTitel)
        numberOfRoomsLabel.autoPinEdge(.leading, to: .trailing, of: numberOfRoomsTitel, withOffset: minPadding)
        numberOfRoomsLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        patioTitel.autoPinEdge(.top, to: .bottom, of: numberOfRoomsLabel, withOffset: minPadding)
        patioTitel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        
        patioLabel.autoAlignAxis(.horizontal, toSameAxisOf: patioTitel)
        patioLabel.autoPinEdge(.leading, to: .trailing, of: patioTitel, withOffset: minPadding)
        patioLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
        daysSincePublishTitel.autoPinEdge(.top, to: .bottom, of: patioLabel, withOffset: minPadding)
        daysSincePublishTitel.autoPinEdge(toSuperviewEdge: .leading, withInset: smallPadding)
        
        daysSincePublishLabel.autoAlignAxis(.horizontal, toSameAxisOf: daysSincePublishTitel)
        daysSincePublishLabel.autoPinEdge(.leading, to: .trailing, of: daysSincePublishTitel, withOffset: minPadding)
        daysSincePublishLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: smallPadding)
        
       
    }
    
}
