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
        label.text = NSLocalizedString("LivingArea", comment: "")
        label.backgroundColor = .green
        return label
    }()
    
    var livingAreaLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.backgroundColor = .gray
        return label
    }()
    
    var numberOfRoomsLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var numberOfRoomsTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = NSLocalizedString("NumberOfRooms", comment: "")
        return label
    }()
    
    var patioLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var patioTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = NSLocalizedString("Patio", comment: "")
        return label
    }()
    
    var daysSincePublishLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        return label
    }()
    
    var daysSincePublishTitel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.text = NSLocalizedString("DaysSincePublish", comment: "")
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
        
        houseImage.autoPinEdge(toSuperviewSafeArea: .top, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        houseImage.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        houseImage.autoSetDimension(.height, toSize: 250)
        
        addressLabel.autoPinEdge(.top, to: .bottom, of: houseImage, withOffset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        addressLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        municipalityAreaLabel.autoPinEdge(.top, to: .bottom, of: addressLabel, withOffset: minPadding)
        municipalityAreaLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        municipalityAreaLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        askingPriceLabel.autoPinEdge(.top, to: .bottom, of: municipalityAreaLabel, withOffset: minPadding)
        askingPriceLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        askingPriceLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        homeDescriptionLabel.autoPinEdge(.top, to: .bottom, of: askingPriceLabel, withOffset: smallPadding)
        homeDescriptionLabel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        homeDescriptionLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)

        livingAreaTitel.autoPinEdge(.top, to: .bottom, of: homeDescriptionLabel, withOffset: midlePadding)
        livingAreaTitel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)

        livingAreaLabel.autoAlignAxis(.horizontal, toSameAxisOf: livingAreaTitel)
        livingAreaLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        livingAreaLabel.autoPinEdge(.leading, to: .trailing, of: livingAreaTitel, withOffset: minPadding)
        
        
        numberOfRoomsTitel.autoPinEdge(.top, to: .bottom, of: livingAreaLabel, withOffset: minPadding)
        numberOfRoomsTitel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        
        numberOfRoomsLabel.autoAlignAxis(.horizontal, toSameAxisOf: numberOfRoomsTitel)
        numberOfRoomsLabel.autoPinEdge(.leading, to: .trailing, of: numberOfRoomsTitel, withOffset: minPadding)
        numberOfRoomsLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        patioTitel.autoPinEdge(.top, to: .bottom, of: numberOfRoomsLabel, withOffset: minPadding)
        patioTitel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        
        patioLabel.autoAlignAxis(.horizontal, toSameAxisOf: patioTitel)
        patioLabel.autoPinEdge(.leading, to: .trailing, of: patioTitel, withOffset: minPadding)
        patioLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        daysSincePublishTitel.autoPinEdge(.top, to: .bottom, of: patioLabel, withOffset: minPadding)
        daysSincePublishTitel.autoPinEdge(toSuperviewSafeArea: .leading, withInset: smallPadding)
        daysSincePublishTitel.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        
        daysSincePublishLabel.autoAlignAxis(.horizontal, toSameAxisOf: daysSincePublishTitel)
        daysSincePublishLabel.autoPinEdge(.leading, to: .trailing, of: daysSincePublishTitel, withOffset: minPadding)
        daysSincePublishLabel.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: smallPadding)
        
        
       
    }
    
}
