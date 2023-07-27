//
//  HeaderTableView.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

final class HeaderForTableView: BaseView {
    
    private let parentName = TextField(placeholder: "Имя").withConstraints()
    private let parentAge = TextField(placeholder: "Возраст").withConstraints()
    
    var maxChildCount = 5
    
    private lazy var parentLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.font = .boldSystemFont(ofSize: 20)
        return label.withConstraints()
    }()
    
    private lazy var infoParentStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.addArrangedSubview(parentName)
        view.addArrangedSubview(parentAge)
        return view.withConstraints()
    }()
    
    private lazy var descChildLabel: UILabel = {
       let label = UILabel()
        label.text = "Дети (макс. \(maxChildCount))"
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label.withConstraints()
    }()
    
    private lazy var addChildButton: AddChildButton = {
       let button = AddChildButton()
        button.setTitle(" Добавить ребенка")
        button.addTarget(self, action: #selector(didTapAddChildButton), for: .touchUpInside)
        return button.withConstraints()
    }()
    
    private lazy var infoChildStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.addArrangedSubview(descChildLabel)
        view.addArrangedSubview(addChildButton)
        view.alignment = .fill
        return view.withConstraints()
    }()
    
    override func setupViews() {
        addSubview(parentLabel)
        addSubview(infoParentStackView)
        addSubview(infoChildStackView)
    }
    
    override func constraintViews() {
        NSLayoutConstraint.activate([
            parentLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            parentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            parentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            infoParentStackView.topAnchor.constraint(equalTo: parentLabel.bottomAnchor, constant: 10),
            infoParentStackView.leadingAnchor.constraint(equalTo: parentLabel.leadingAnchor),
            infoParentStackView.trailingAnchor.constraint(equalTo: parentLabel.trailingAnchor),
            
            infoChildStackView.topAnchor.constraint(equalTo: infoParentStackView.bottomAnchor, constant: 10),
            infoChildStackView.leadingAnchor.constraint(equalTo: parentLabel.leadingAnchor),
            infoChildStackView.trailingAnchor.constraint(equalTo: parentLabel.trailingAnchor),
            infoChildStackView.heightAnchor.constraint(equalToConstant: 40),
            infoChildStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
        ])
    }
    
    @objc func didTapAddChildButton() {
        print("Child button tapped")
    }
}