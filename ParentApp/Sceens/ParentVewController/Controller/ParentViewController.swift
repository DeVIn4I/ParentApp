//
//  ViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class ParentViewController: UIViewController {
    
    private let header = HeaderForTableView().withConstraints()
        
    private lazy var table: UITableView = {
       let view = UITableView()
        view.register(ChildCell.self, forCellReuseIdentifier: ChildCell.reuseID)
        view.dataSource = self
        view.delegate = self
        return view.withConstraints()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            header.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
    }
}

extension ParentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.reuseID) as! ChildCell
        cell.contentView.backgroundColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    
}

extension ParentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
