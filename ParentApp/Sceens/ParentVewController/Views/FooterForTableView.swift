//
//  FooterForTableView.swift
//  ParentApp
//
//  Created by Pavel Razumov on 28.07.2023.
//

import UIKit

final class FooterForTableView: BaseView {
    
    private lazy var separatoView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view.withConstraints()
    }()
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.myRed, for: .normal)
        button.addTarget(self, action: #selector(didTapClearButton), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.myRed.cgColor
        button.layer.borderWidth = 2
        return button.withConstraints()
    }()
    
    var clearButtonAction: (() -> Void)?
    
    override func setupViews() {
        addSubview(separatoView)
        addSubview(clearButton)
        backgroundColor = .white
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            separatoView.topAnchor.constraint(equalTo: topAnchor),
            separatoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatoView.heightAnchor.constraint(equalToConstant: 1),
            
            clearButton.widthAnchor.constraint(equalToConstant: 180),
            clearButton.heightAnchor.constraint(equalToConstant: 40),
            clearButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            clearButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc func didTapClearButton() {
        Haptic.impact(.heavy)
        clearButtonAction?()
    }
}

