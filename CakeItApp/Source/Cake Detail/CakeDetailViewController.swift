//
//  CakeDetailViewController.swift
//  CakeItApp
//
//  Created by David McCallum on 21/01/2021.
//

import UIKit

class CakeDetailViewController: UIViewController {
    
    @IBOutlet private weak var cakeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    let viewModel = CakeDetailViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getDesc()
        guard let imageURL = viewModel.getImageURL(),
              let data = try? Data(contentsOf: imageURL) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.cakeImageView.image = UIImage(data: data)
        }
    }
}

extension CakeDetailViewController {
    
    /// Sets up the view model with the tapped cake
    /// - Parameter cake: Cake object to be displayed
    func setupViewModel(with cake: Cake){
        viewModel.setModel(input: cake)
    }
}
