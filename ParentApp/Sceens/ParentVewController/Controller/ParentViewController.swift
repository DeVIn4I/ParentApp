//
//  ViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class ParentViewController: UIViewController {
    
    private let header = HeaderForTableView().withConstraints()
    
    var childs: [Child] = []
        
    private lazy var table: UITableView = {
       let view = UITableView()
        view.register(ChildCell.self, forCellReuseIdentifier: ChildCell.reuseID)
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.allowsSelection = false
        return view.withConstraints()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            table.topAnchor.constraint(equalTo:view.topAnchor, constant: 20),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension ParentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.reuseID) as! ChildCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        header.addChildAction = { [weak self] in
            guard let self else { return }
            
            self.childs.append(Child())
            tableView.insertRows(at: [IndexPath(row: childs.count-1, section: 0)], with: .fade)
        }
        
        
        return header
    }
    
    
}

extension ParentViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }


}

