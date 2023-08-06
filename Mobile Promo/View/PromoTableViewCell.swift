//
//  PromoTableViewCell.swift
//  Mobile Promo
//
//  Created by William Yulio on 04/08/23.
//

import UIKit
import SDWebImage
class PromoTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    public let promoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowRadius = 3.0
        container.layer.shadowOffset = CGSize.init(width: 0.5, height: 3)
        container.layer.shadowOpacity = 0.3
        
        let backgroundCGColor = container.backgroundColor?.cgColor
        container.backgroundColor = nil
        container.layer.backgroundColor =  backgroundCGColor
        container.layer.shouldRasterize = true
        container.layer.rasterizationScale = UIScreen.main.scale
        return container
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupLayout(){
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(promoImage)
        self.contentView.backgroundColor = .white

        NSLayoutConstraint.activate([
            
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 180),
            containerView.widthAnchor.constraint(equalToConstant: 360),
            
            contentView.heightAnchor.constraint(equalToConstant: 200),
            
            promoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            promoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            promoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            promoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            promoImage.heightAnchor.constraint(equalToConstant: 180),
            

        ])
    }
    
    func getImageFromURL(imageURL: String?){
        if let imageURL = imageURL {
            guard let CompleteURL = URL(string: imageURL) else {return}
            self.promoImage.sd_setImage(with: CompleteURL)
        }
    }

}
