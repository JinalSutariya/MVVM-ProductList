//
//  ProductViewModel.swift
//  MVVM ProductsList
//
//  Created by CubezyTech on 14/03/24.
//

import Foundation


final class ProductViewModel{
    
    
    var products: [Product] = []
    
    var eventHandler : ((_ event: Event) -> Void)?
    func fetchProducts(){
        self.eventHandler?(.loading)
        APIManager.shared.fetchProducts { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.products = product
                self.eventHandler?(.dataLoaded)
                print(product)
            case .failure(let error):
                self.eventHandler?(.error(error))
                print(error)
            }
        }
    }
}

extension ProductViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
