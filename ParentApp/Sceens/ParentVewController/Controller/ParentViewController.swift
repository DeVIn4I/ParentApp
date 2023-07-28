//
//  ViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class ParentViewController: UIViewController {
    //MARK: - Properties
    private let header = HeaderForTableView()
    private let footer = FooterForTableView()
    private let alertModel = AlertModel(
        title: "Очистить форму",
        message: "Удалить все записи?",
        buttonText: "Очистить"
    )
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
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        view.backgroundColor = .white
        view.addSubview(table)
        
        NSLayoutConstraint.activate([
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            table.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        hideKeyboardWhenTappedAround()
    }
    //MARK: - Methods
    private func showAlert() {
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
                    self?.showAddChildButton()
                }
            let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(clearButton)
            alert.addAction(cancelButton)
            present(alert, animated: true)
        }
    }
    
    private func showAddChildButton() {
        UIView.animate(withDuration: 0.3) {
            self.header.addChildButton.alpha = 1
        }
    }
    
    private func hideAddChildButton() {
        UIView.animate(withDuration: 0.3) {
            self.header.addChildButton.alpha = 0
        }
    }

}
//MARK: - ParentViewController: UITableViewDataSource
extension ParentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.reuseID) as! ChildCell
        cell.deleteChildAction = { [weak self] in
            guard let self else { return }
            if childs.count <= header.maxChildCount {
                showAddChildButton()
            }
//                        cell.clear()
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
                hideAddChildButton()
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
//MARK: - ParentViewController: UITableViewDelegate
extension ParentViewController: UITableViewDelegate {}

