//
//  BaseView.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func setupViews() {}
    func constraintViews() {}
    func configureAppearance() {}
}

