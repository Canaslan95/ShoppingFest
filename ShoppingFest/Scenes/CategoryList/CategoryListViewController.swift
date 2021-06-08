//
//  CategoryListViewController.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 3.06.2021.
//

import UIKit

class CategoryListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CategoryListViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setRightBarButton()
        title = viewModel.screenTitle
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadItems { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "CategoryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryListTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: CategoryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "CategoryListViewController", bundle: nil)
    }
    
    private func setRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self , action: #selector(rightButtonAction))
    }

    @objc func rightButtonAction() {
        let viewModel = AddItemViewModel(category: self.viewModel.category)
        let controller = AddItemViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell") as? CategoryListTableViewCell
        cell?.generateCell(item: viewModel.itemArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = ItemsViewModel(item: self.viewModel.itemArray[indexPath.row])
        let controller = ItemsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
