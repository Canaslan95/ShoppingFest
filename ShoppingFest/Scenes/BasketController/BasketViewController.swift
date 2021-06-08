//
//  BasketViewController.swift
//  ShoppingFest
//
//  Created by Oğulcan Aslan on 7.06.2021.
//

import UIKit
import JGProgressHUD

class BasketViewController: UIViewController {
    
    @IBOutlet weak var ItemsBasketLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalItemsLabel: UILabel!
    
    let hud = JGProgressHUD(style: .dark)
    
    var viewModel = BasketViewModel()
    
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "BasketViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        applyStyle()
    }
    
    func applyStyle() {
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.delegate = self
        tableView.dataSource = self
        loadBasketFromFirestore()
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "CategoryListTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryListTableViewCell")
    }
    
    private func loadBasketFromFirestore() {
        downloadBasketFromFirestore("1234") { (basket) in
            self.viewModel.baskets = basket
            self.viewModel.getBasketItems {
                self.totalItemsLabel.text = self.viewModel.allItems.count.description
                self.tableView.reloadData()
            }
        }
    }

    private func updateTotalLabels(_ isEmpty: Bool) {
        if isEmpty {
            totalItemsLabel.text = "0"
            totalItemsLabel.text = returnBasketTotalPrice()
        } else {
            totalItemsLabel.text = "\(viewModel.allItems.count)"
            totalItemsLabel.text = returnBasketTotalPrice()
        }
    }
    
    private func returnBasketTotalPrice() -> String {
        var totalPrice = 0.0
        for item in viewModel.allItems {
            totalPrice += item.price
        }
        return "Total price: " + convertToCurrency(totalPrice)
    }
    
    private func showItemView(withItem: Item) {
        let viewModel = ItemsViewModel(item: withItem)
        let controller = ItemsViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListTableViewCell") as? CategoryListTableViewCell
        cell?.generateCell(item: viewModel.allItems[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(withItem: viewModel.allItems[indexPath.row])
    }
    
}
