//
//  ViewController.swift
//  Mobile Promo
//
//  Created by William Yulio on 04/08/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PromoTableViewCell.self, forCellReuseIdentifier: PromoTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var promoViewModel: PromoViewModel = PromoViewModel()
    var tableViewCellData: [PromoElement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Semua Promo"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        setupLayout()
        setupBinding()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        promoViewModel.getDataFromAPI()
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
    }
    
    func setupLayout(){
        view.addSubview(tableView)
        view.backgroundColor = .white
//        tableView.pin(to: view)
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promoViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoTableViewCell.identifier, for: indexPath) as? PromoTableViewCell else {
            fatalError("The tableview couldn't dequeue a Custom Cell in ViewController")
        }
        cell.nameLabel.text = self.tableViewCellData[indexPath.row].nama
        cell.getImageFromURL(imageURL: self.tableViewCellData[indexPath.row].img?.formats.medium.url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promoId = tableViewCellData[indexPath.row].id ?? 0
        self.goToDetail(promoId: promoId)
    }
    
    func setupBinding(){
        promoViewModel.cellDataSource.bind { [weak self] promos in
            guard let self = self, let promos = promos else { return }
            tableViewCellData = promos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func goToDetail(promoId: Int?){
        guard let promoData = promoViewModel.retrievePromo(with: promoId) else{
            return
        }
        
        let detailPromoVM = DetailPromoViewModel(promo: promoData)
        let detailPromoVC = DetailPromoViewController(detailPromoVM: detailPromoVM)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailPromoVC, animated: true)
        }
        
    }


}

