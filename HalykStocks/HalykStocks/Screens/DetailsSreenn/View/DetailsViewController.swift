//
//  DetailsViewController.swift
//  HalykStocks
//
//  Created by Даурен on 27.05.2022.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {
    private let presenter: DetailsPresenterProtocol
    
    init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var favoriteView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "fav_det")
        return image
    }()
    
    private lazy var stockSymbol: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratBold, size: 24)
        lbl.textColor = .black
        lbl.text = "BIT"
        return lbl
    }()
    
    private lazy var companyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 16)
        lbl.textColor = .black
        lbl.text = "bit"
        return lbl
    }()
    
    private lazy var currentPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratBold, size: 32)
        lbl.textColor = .black
        lbl.text = "124.11 $"
        return lbl
    }()
    
    private lazy var dayDelta: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 16)
        lbl.textColor = .black
        lbl.text = "-12.3 %"
        return lbl
    }()
    
    private lazy var chartView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(named: "launch")
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        print("details VC")
        presenter.loadView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        [stockSymbol, companyLabel, currentPrice, dayDelta, favoriteView, chartView].forEach {
            view.addSubview($0)
        }
        
        stockSymbol.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(stockSymbol.snp.bottom).offset(5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        
        currentPrice.snp.makeConstraints { make in
            make.top.equalTo(companyLabel.snp.bottom).offset(76)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        dayDelta.snp.makeConstraints { make in
            make.top.equalTo(currentPrice.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        favoriteView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-17)
            make.top.equalTo(view.snp.top).offset(54)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(dayDelta.snp.bottom).offset(40)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
        }
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func updateView() {
        
    }
    
    func updateView(withLoader isLoading: Bool) {
        
    }
    
    func updateView(withError message: String) {
        
    }
    

}
