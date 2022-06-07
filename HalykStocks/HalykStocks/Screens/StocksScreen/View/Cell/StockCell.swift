//
//  StockCell.swift
//  HalykStocks
//
//  Created by Даурен on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    private var favoriteAction: (() -> Void)?
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "AMZN")
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        return image
    }()
    
    private lazy var symbolLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "AMZN"
        lbl.font = UIFont.customFont(name: .moserratBold, size: 18)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var companyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Amazon.com"
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 12)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "favorite"), for: .normal)
        btn.setImage(UIImage(named: "favorite_selected"), for: .selected)
        btn.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentPrice: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "$131.93"
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratBold, size: 18)
        lbl.textColor = .black
        return lbl
    }()
    
    private lazy var dayDeltaChange: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "+$0.12"
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 12)
        lbl.textColor = .stocksDeltaGreen
        return lbl
    }()
    
    private lazy var dayDeltaPercentage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "(1,15%)"
        lbl.textAlignment = .center
        lbl.font = UIFont.customFont(name: .moserratMedium, size: 12)
        lbl.textColor = .stocksDeltaGreen
        return lbl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoriteAction = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favoriteTapped() {
        favoriteButton.isSelected.toggle()
        favoriteAction?()
    }
    
    func setBackgroundColor(for row: Int) {
        backView.backgroundColor = row % 2 == 0 ? UIColor.stocksGrey : UIColor.stocksWhite
    }
    
    func configure(with stocks: StockModelProtocol) {
        symbolLabel.text = stocks.symbol
        companyLabel.text = stocks.name
        currentPrice.text = stocks.price

        dayDeltaChange.text = stocks.change
        dayDeltaPercentage.text = stocks.changePercentage
            
        dayDeltaChange.textColor = stocks.changeColor
        dayDeltaPercentage.textColor = stocks.changeColor
        
        favoriteButton.isSelected = stocks.isFavorite
        favoriteAction = {
            stocks.favoriteTapped()
        }
    }
    
    private func setupSubview() {
        setupCellViews()
        setupTextView()
        setupPriceView()
    }
    
    private func setupCellViews() {
        contentView.addSubview(backView)
        
        [iconView, textView, priceView].forEach { view in
            backView.addSubview(view)
        }
        
        backView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(8)
            make.left.equalTo(backView.snp.left).offset(8)
            make.bottom.equalTo(backView.snp.bottom).offset(-8)
            make.height.width.equalTo(52)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(14)
            make.left.equalTo(iconView.snp.right).offset(12)
            make.bottom.equalTo(backView.snp.bottom).offset(-14)
        }
        
        priceView.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(14)
            make.right.equalTo(backView.snp.right).offset(-12)
            make.bottom.equalTo(backView.snp.bottom).offset(-14)
        }
    }
    
    private func setupTextView() {
        [symbolLabel, companyLabel, favoriteButton].forEach { view in
            textView.addSubview(view)
        }

        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top)
            make.left.equalTo(textView.snp.left)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.left.equalTo(symbolLabel.snp.right).offset(6)
            make.right.equalTo(textView.snp.right)
            make.centerY.equalTo(symbolLabel.snp.centerY)
            make.height.width.equalTo(16)
        }
        
        companyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(textView.snp.bottom)
            make.left.equalTo(textView.snp.left)
        }
    }
    
    private func setupPriceView() {
        [currentPrice, dayDeltaChange, dayDeltaPercentage].forEach { view in
            priceView.addSubview(view)
        }
        
        currentPrice.snp.makeConstraints { make in
            make.right.equalTo(priceView.snp.right)
            make.top.equalTo(priceView.snp.top)
        }
        
        dayDeltaChange.snp.makeConstraints { make in
            make.left.equalTo(priceView.snp.left)
            make.right.equalTo(dayDeltaPercentage.snp.left).offset(-5)
            make.bottom.equalTo(priceView.snp.bottom)
        }
        
        dayDeltaPercentage.snp.makeConstraints { make in
            make.right.equalTo(priceView.snp.right)
            make.bottom.equalTo(priceView.snp.bottom)
        }
    }
}
