//
//  ChildCell.swift
//  ParentApp
//
//  Created by Pavel Razumov on 27.07.2023.
//

import UIKit

class ChildCell: UITableViewCell {
    
    static let reuseID = "childCell"
    
    private let childName = TextField(placeholder: "Имя")
    private let childAge = TextField(placeholder: "Возраст")
    
    var deleteChildAction: (() -> Void)?
    
    private lazy var infoChildStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(childName)
        view.addArrangedSubview(childAge)
        view.axis = .vertical
        view.spacing = 10
        return view.withConstraints()
    }()
    
    private lazy var deleteChildButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.myBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapDeleteChildButton), for: .touchUpInside)
        return button.withConstraints()
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(deleteChildButton)
        view.alignment = .top
        return view.withConstraints()
    }()
    
    private lazy var fullStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(infoChildStackView)
        view.addArrangedSubview(buttonStackView)
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .fill
        return view.withConstraints()
    }()
    
    private var child: Child?
    
    var didChangeChild: ((Child?) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        childName.text = nil
        childAge.text = nil
    }
    
    private func setupView() {
        contentView.addSubview(fullStackView)
        backgroundColor = .white
        
        childAge.keyboardType = .numberPad
        
        NSLayoutConstraint.activate([
            deleteChildButton.widthAnchor.constraint(equalToConstant: 120),
            deleteChildButton.heightAnchor.constraint(equalToConstant: 40),
            buttonStackView.widthAnchor.constraint(equalTo: deleteChildButton.widthAnchor),
            
            fullStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            fullStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            fullStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            fullStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupActions() {
        childName.didEditingChanged = { [weak self] text in
            guard let self else { return }
            child?.name = text
            didChangeChild?(child)
        }
        childAge.didEditingChanged = { [weak self] text in
            guard
                let self,
                let text,
                let age = Int(text)
            else { return }
            child?.age = age
            didChangeChild?(child)
        }
    }
    
    func render(_ model: Child) {
        child = model
        childName.text = model.name
        
        if let age = model.age {
            childAge.text = String(age)
        }
    }
    
    @objc func didTapDeleteChildButton() {
        deleteChildAction?()
    }
}



