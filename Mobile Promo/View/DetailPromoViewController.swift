//
//  DetailPromoViewController.swift
//  Mobile Promo
//
//  Created by William Yulio on 05/08/23.
//

import UIKit
import SDWebImage
class DetailPromoViewController: UIViewController {
    
    public let promoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    public let descLabel: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 18, weight: .medium)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.backgroundColor = .white
        textView.isScrollEnabled = false
        return textView
    }()
    
    var detailPromoVM: DetailPromoViewModel
    
    init(detailPromoVM: DetailPromoViewModel) {
        self.detailPromoVM = detailPromoVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureContent()
        setupLayout()
    }
    
    func configureContent(){
        self.title = "Detail Promo"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        titleLabel.text = detailPromoVM.name
        descLabel.text = detailPromoVM.desc
        promoImage.sd_setImage(with: detailPromoVM.imgURL)
    }
    
    func setupLayout(){
        view.addSubview(promoImage)
        view.addSubview(titleLabel)
        view.addSubview(descLabel)
        view.backgroundColor = .white

        NSLayoutConstraint.activate([
            
            promoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            promoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            promoImage.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: promoImage.bottomAnchor, constant: 20),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            view.trailingAnchor.constraint(equalTo: descLabel.trailingAnchor, constant: 15),
            

        ])
    }
    

}
