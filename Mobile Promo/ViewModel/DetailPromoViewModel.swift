//
//  PromoCellViewModel.swift
//  Mobile Promo
//
//  Created by William Yulio on 05/08/23.
//

import Foundation
import UIKit

class DetailPromoViewModel{
    var promo: PromoElement
    var id: Int
    var name, desc: String
    var imgURL: URL?
    
    init(promo: PromoElement){
        self.promo = promo
        self.id = promo.id ?? 0
        self.name = promo.nama ?? ""
        self.desc = promo.desc ?? ""
        self.imgURL = convertImgToURL(promo.img?.formats.medium.url ?? "")
    }
    
    private func convertImgToURL(_ imgURL: String) -> URL?{
        return URL(string: imgURL)
    }
}
