//
//  CakeListViewModel.swift
//  CakeItApp
//
//  Created by Usman on 25/04/2022.
//

import Foundation
import Combine

class CakeListViewModel {
    private var model: [Cake] = []
    private var observers = [AnyCancellable]()
    var subject = PassthroughSubject<Bool, Never>()
}

extension CakeListViewModel {
    
    func numberOfCakes() -> Int {
        return model.count
    }
    
    func getCake(at index: Int) -> Cake {
        return model[index]
    }
}

extension CakeListViewModel: CakeService {
    func fetchCakes() {
        getCakes()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.subject.send(false)
                case .finished:
                    self?.subject.send(true)
                }
            } receiveValue: { [weak self] cakes in
                self?.model = cakes
            }.store(in: &observers)
    }
}
