//
//  ViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 26.07.2023.
//

import UIKit

class ParentViewController: UIViewController {
    //MARK: - Properties
    private let header = HeaderForTableView().withConstraints()
    private let footer = FooterForTableView().withConstraints()
    
    private let alertModel = AlertModel(
        title: "Очистить форму",
        message: "Удалить все записи?",
        buttonText: "Очистить"
    )
    
    var parentOne: Parent = Parent()
    
    private lazy var table: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
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
        setupActions()
        view.backgroundColor = .white
        view.addSubview(header)
        view.addSubview(table)
        view.addSubview(footer)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.topAnchor.constraint(equalTo: header.bottomAnchor),
            
            footer.topAnchor.constraint(equalTo: table.bottomAnchor),
            footer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            footer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            
        ])
        hideKeyboardWhenTappedAround()
    }
    //MARK: - Methods
    private func showAlert() {
            let alert = UIAlertController(
                title: alertModel.title,
                message: alertModel.message, preferredStyle: .actionSheet)
            let clearButton = UIAlertAction(
                title: alertModel.buttonText, style: .destructive) { [weak self] _ in
                    self?.header.clearData()
                    self?.parentOne.childs = []
                    self?.table.reloadData()
                    self?.showAddChildButton()
                }
            let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
            alert.addAction(clearButton)
            alert.addAction(cancelButton)
            present(alert, animated: true)
        }
    
    private func showAddChildButton() {
        UIView.animate(withDuration: 0.3) {
            self.header.addChildAlpha = 1
        }
    }
    
    private func hideAddChildButton() {
        UIView.animate(withDuration: 0.3) {
            self.header.addChildAlpha = 0
        }
    }
    
    func setupActions() {
        //MARK: - HeaderAction
        header.addChildAction = { [weak self] in
            guard let self else { return }
            
            if parentOne.childs.count == header.maxChildCount - 1 {
                hideAddChildButton()
            }
            table.beginUpdates()
            parentOne.childs.insert(Child(), at: 0)
            table.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            table.reloadSections(IndexSet(integer: 0), with: .fade)
            table.endUpdates()
        }
        footer.clearButtonAction = { [weak self] in
            guard let self else { return }
            showAlert()
        }
    }
}
//MARK: - ParentViewController: UITableViewDataSource
extension ParentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentOne.childs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChildCell.reuseID) as! ChildCell
        
        cell.render(parentOne.childs[indexPath.row])
        
        
        cell.didChangeChild = { [weak self] child in
            guard let child, let self else { return }
            guard let index = tableView.indexPath(for: cell)?.row else { return }
            parentOne.childs[index] = child
        }
        
        cell.deleteChildAction = { [weak self] in
            guard let self else { return }
            if parentOne.childs.count <= header.maxChildCount {
                showAddChildButton()
            }
            guard let index = tableView.indexPath(for: cell) else { return }
            table.beginUpdates()
            parentOne.childs.remove(at: index.row)
            table.deleteRows(at: [indexPath], with: .fade)
            table.reloadSections(IndexSet(integer: 0), with: .fade)
            table.endUpdates()
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        !parentOne.childs.isEmpty ? footer : nil
//    }
}
//MARK: - ParentViewController: UITableViewDelegate
extension ParentViewController: UITableViewDelegate {}

