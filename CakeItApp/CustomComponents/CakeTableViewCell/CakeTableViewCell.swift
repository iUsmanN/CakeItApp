//
//  CakeTableViewCell.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import UIKit

class CakeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    /// Sets up the cake cell with the cake input
    /// - Parameter input: Cake input to be shown
    func setupCell(input: Cake) {
        titleLabel.text = input.title
        descLabel.text = input.desc
        
        guard let imageURL = URL(string: input.image),
              let data = try? Data(contentsOf: imageURL) else { return }
        DispatchQueue.main.async { [weak self] in
            self?.cakeImageView.image = UIImage(data: data)
        }
    }
}
