//
//  PromoViewModel.swift
//  Mobile Promo
//
//  Created by William Yulio on 04/08/23.
//

import Foundation
import UIKit

class PromoViewModel{
    
    var dataSource: [PromoElement]?
    var cellDataSource: ObservableObject<[PromoElement]> = ObservableObject(nil)
    
    func numberOfRows() -> Int{
        return self.dataSource?.count ?? 0
    }
    
    func getDataFromAPI(){
        networkManager.shared.fetchPromosData { [weak self] result in
            switch result{
            case .success(let data):
                self?.dataSource = data
                self?.mapCelldata()
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
    }
    
    func mapCelldata(){
        self.cellDataSource.value = dataSource ?? []
    }
    
    func retrievePromo(with promoId: Int?) -> PromoElement?{
        
        guard let promo = dataSource?.first(where: { $0.id == promoId}) else {
            return nil
        }
        
        return promo
    }
}
