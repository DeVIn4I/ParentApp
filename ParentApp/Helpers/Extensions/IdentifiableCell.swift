//
//  IdentifiableCell.swift
//  ParentApp
//
//  Created by Pavel Razumov on 30.07.2023.
//

import UIKit

protocol Identifiable {
    static var reuseID: String { get }
}

extension Identifiable {
    static var reuseID: String {
        "\(self)"
    }
}

extension UITableViewCell: Identifiable {}
