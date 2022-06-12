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
    
    private lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "favorite"), for: .normal)
        btn.setImage(UIImage(named: "favorite_selected"), for: .selected)
        btn.isSelected = presenter.favButtonSelected
        btn.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return btn
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
    

    
    private lazy var buyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor.black
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("BUY", for: .normal)
        btn.titleLabel?.font = UIFont.customFont(name: .moserratBold, size: 20)
        btn.layer.cornerRadius = 12
        btn.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        btn.layer.cornerCurve = .continuous
        return btn
    }()

    private lazy var chartView = ChartsView()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubviews()
        print("details VC")
        configure(with: presenter.dataConfigure())
        presenter.loadCharts()
    }
    
    @objc private func favoriteTapped(sender: UIButton) {
        sender.isSelected.toggle()
        presenter.favTapped()
    }
    
    @objc private func buyButtonTapped(sender: UIButton) {
        print("buy tapped")
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        [stockSymbol, companyLabel, currentPrice, dayDelta, chartView, buyButton].forEach {
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
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(dayDelta.snp.bottom).offset(40)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(52)
            make.height.equalTo(56)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    private func configure(with stocks: StockModelProtocol) {
        stockSymbol.text = stocks.symbol
        companyLabel.text = stocks.name
        currentPrice.text = stocks.price
        dayDelta.text = stocks.change
        dayDelta.textColor = stocks.changeColor
    }
}

extension DetailsViewController: DetailsViewProtocol {
    func updateView(with model: DetailsResponse) {
        chartView.configure(with: .build(from: model))
    }

    func updateView(withLoader isLoading: Bool) {
        chartView.configure(with: isLoading)
    }
    
    func updateView(withError message: String) {
    }
}
