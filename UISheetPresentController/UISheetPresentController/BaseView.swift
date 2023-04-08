//
//  BaseView.swift
//  UISheetPresentController
//
//  Created by Devanand Chauhan on 29/03/23.
//

import UIKit

@IBDesignable
class BaseView: UIView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        //Implemented by child classes
    }
}
