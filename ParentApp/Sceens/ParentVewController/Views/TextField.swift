//
//  TextField.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

final class TextField: BaseView {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 18)
        textField.borderStyle = .none
        
        return textField.withConstraints()
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        
        return label.withConstraints()
    }()
    
    convenience init(placeholder: String) {
        self.init()
        placeholderLabel.text = placeholder
    }
    
    override func setupViews() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(textField)
        addSubview(placeholderLabel)
    }
    
    override func constraintViews() {
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            
            placeholderLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: 8),
            
            heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
