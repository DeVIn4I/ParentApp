//
//  TestViewController.swift
//  ParentApp
//
//  Created by Pavel Razumov on 30.07.2023.
//

import UIKit

import UIKit

class YourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Ваш массив данных для таблицы
    var dataArray: [String] = ["Ячейка 1", "Ячейка 2", "Ячейка 3"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Настройка делегата и источника данных для таблицы
        tableView.dataSource = self
        tableView.delegate = self

        // Создание кнопки для добавления новых ячеек
        let addButton = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addNewCell))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addNewCell() {
        // Создание нового элемента данных для таблицы
        let newCellData = "Новая ячейка \(dataArray.count + 1)"

        // Добавление нового элемента в начало массива данных
        dataArray.insert(newCellData, at: 0)

        // Вставка новой ячейки в начало таблицы с анимацией
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellId", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    // Дополнительные методы делегата и источника данных таблицы могут быть добавлены здесь, если необходимо

}

