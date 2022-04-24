//
//  CakeListViewController.swift
//  CakeItApp
//
//  Created by David McCallum on 20/01/2021.
//

import UIKit
import Combine

class CakeListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    private var i = 0
    private var viewModel = CakeListViewModel()
    private var observers = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
}

extension CakeListViewController {
    
    /// Setups View Controller
    func setupView() {
        tableView.register(UINib(nibName: "CakeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        title = "🎂CakeItApp🍰"
    }
    
    /// Connects View Controller to the View Model
    func bindViewModel() {
        viewModel.subject.sink(receiveValue: { [weak self] success in
            if success {
                DispatchQueue.main.async { self?.tableView.reloadData() }
            } else {
                print("Show Error")
            }
        }).store(in: &observers)
        viewModel.fetchCakes()
    }
}

extension CakeListViewController: UITableViewDelegate, ViewControllerInstantiator {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /// Replaced Segue with instantiating View Controller to avoid using the extra variable "i" for data passing during performing segue.
        guard let viewController = newViewController(storyboard: .Main, viewController: .CakeDetailViewController) as? CakeDetailViewController else { return }
        let cake = viewModel.getCake(at: indexPath.row)
        viewController.setupViewModel(with: cake)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension CakeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCakes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? CakeTableViewCell else {
            return UITableViewCell()
        }
        let cake = viewModel.getCake(at: indexPath.row)
        cell.setupCell(input: cake)
        return cell
    }
}

