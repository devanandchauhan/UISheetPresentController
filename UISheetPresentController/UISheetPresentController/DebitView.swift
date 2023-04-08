//
//  DebitView.swift
//  UISheetPresentController
//
//  Created by Devanand Chauhan on 29/03/23.
//

import UIKit

@IBDesignable
class DebitView: BaseView {

    lazy var offerLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.5
        return $0
    }(UILabel())
    
    lazy var offerImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    let rightIndicator: UIImageView = {
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override func setupViews() {
        
        backgroundColor = .white
        cornerRadius = 6
        
        addSubview(offerLabel)
        addSubview(offerImageView)
        addSubview(rightIndicator)
        
        setupLayout()
        //setupViewModel()
    }
    
    fileprivate func setupLayout() {
        
        NSLayoutConstraint.activate([
            rightIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightIndicator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 40/116),
            rightIndicator.widthAnchor.constraint(equalTo: rightIndicator.heightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            offerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            offerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: offerLabel.bottomAnchor, constant: 11)
            ])
        
        NSLayoutConstraint.activate([
            offerImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 6),
            offerImageView.leadingAnchor.constraint(equalTo: offerLabel.trailingAnchor, constant: 14),
            offerImageView.trailingAnchor.constraint(equalTo: rightIndicator.leadingAnchor, constant: -14),
            offerImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 125/343),
            offerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 125/78),
            ])
    }

}
