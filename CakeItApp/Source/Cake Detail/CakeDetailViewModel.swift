//
//  CakeDetailViewModel.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation

class CakeDetailViewModel {
    
    private var model: Cake?
    
    func setModel(input: Cake) {
        model = input
    }
    
    func getTitle() -> String? {
        return model?.title
    }
    
    func getDesc() -> String? {
        return model?.desc
    }
    
    func getImageURL() -> URL? {
        guard let imageUrl = model?.image else { return nil }
        return URL(string: imageUrl)
    }
}
