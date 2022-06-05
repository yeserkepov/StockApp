//
//  DetailsViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {
    
    var symbol: String?
    var name: String?
    var price: Double?
    var delta: Double?
    
    private lazy var favorite: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "fav_det")
        return image
    }()
    
    private lazy var stockSymbol: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratBold, size: 24)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var companyLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var currentPrice: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratBold, size: 32)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var dayDelta: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 16)
        lbl.textColor = .black
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockSymbol.text = symbol?.uppercased()
        companyLabel.text = name
        
        currentPrice.text = Double.checkDecimal(check: price)
        dayDelta.text = Double.checkDecimal(check: delta)
        
        view.backgroundColor = .white
        setup()
    }
    
    private func setup() {
        [stockSymbol, companyLabel, currentPrice, dayDelta, favorite].forEach {
            view.addSubview($0)
        }
        
        stockSymbol.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(stockSymbol.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        currentPrice.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(76)
            make.centerX.equalToSuperview()
        }
        
        dayDelta.snp.makeConstraints { make in
            make.top.equalTo(currentPrice.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        favorite.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17)
            make.top.equalToSuperview().offset(54)
        }
    }
}