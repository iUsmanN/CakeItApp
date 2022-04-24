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
    
    func setupView() {
        tableView.register(UINib(nibName: "CakeTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        title = "🎂CakeItApp🍰"
    }
    
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

extension CakeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        i = indexPath.row
        performSegue(withIdentifier: "segue", sender: tableView)
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

