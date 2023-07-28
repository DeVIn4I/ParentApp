//
//  AddChildButton.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

final class AddChildButton: UIButton {
    
    private let title = UILabel().withConstraints()
    private let iconView = UIImageView().withConstraints()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(_ text: String) {
        title.text = text
    }
}

private extension AddChildButton {
    func setupViews() {
        addSubview(title)
        addSubview(iconView)
    }
    func constraintViews() {
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            iconView.heightAnchor.constraint(equalToConstant: 18),
            iconView.widthAnchor.constraint(equalToConstant: 18),
            
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.leadingAnchor.constraint(equalTo: iconView.trailingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    func configureAppearance() {
        layer.borderColor = UIColor.myBlue.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        makeSystem(self)
        
        title.textColor = .myBlue
        title.font = .systemFont(ofSize: 18)
        title.textAlignment = .center
        
        iconView.image = UIImage(systemName: "plus")
        iconView.tintColor = .myBlue
    }
}
