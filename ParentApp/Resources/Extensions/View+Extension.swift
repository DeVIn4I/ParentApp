//
//  View+Extension.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

extension UIView {
    func withConstraints(_ with: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = !with
        return self
    }
}
