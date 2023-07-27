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
    
    private lazy var infoChildStackView: UIStackView = {
        let view = UIStackView()
        view.addArrangedSubview(childName)
        view.addArrangedSubview(childAge)
        view.axis = .vertical
        view.spacing = 10
        return view.withConstraints()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.addSubview(infoChildStackView)
        
        NSLayoutConstraint.activate([
            infoChildStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoChildStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            infoChildStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            infoChildStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
}
    
    

