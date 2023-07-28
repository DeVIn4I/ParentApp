//
//  ViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class ParentViewController: UIViewController {
    
    private let header = HeaderForTableView()
    private let footer = FooterForTableView()
    
    private let alertModel = AlertModel(title: "Очистить форму", message: "Удалить все записи?", buttonText: "Очистить") {
        print(123)
    }
    
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
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            table.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        footer.clearButtonAction = { [weak self] in
            guard let self else { return }
            let alert = UIAlertController(
                title: alertModel.title,
                message: alertModel.message, preferredStyle: .actionSheet)
            let clearButton = UIAlertAction(
                title: alertModel.buttonText, style: .destructive) { [weak self] _ in
                    
                    self?.header.clearData()
                    self?.childs = []
                    self?.table.reloadData()
                }
            let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(clearButton)
            alert.addAction(cancelButton)
            present(alert, animated: true)
        }
    }
}

extension ParentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.reuseID) as! ChildCell
        
        cell.deleteChildAction = { [weak self] in
            guard let self else { return }
            if childs.count <= header.maxChildCount {
                UIView.animate(withDuration: 0.3) {
                    self.header.addChildButton.alpha = 1
                }
            }
            cell.clear()
            childs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        header.addChildAction = { [weak self] in
            guard let self else { return }
            
            if childs.count == header.maxChildCount - 1 {
                
                UIView.animate(withDuration: 0.3) {
                    self.header.addChildButton.alpha = 0
                }
            }
            childs.append(Child())
            tableView.insertRows(at: [IndexPath(row: childs.count-1, section: 0)], with: .fade)
            tableView.reloadData()
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        !childs.isEmpty ? footer : nil
    }
}

extension ParentViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }


}

