//
//  StockCell.swift
//  HalykStocks
//
//  Created by Даурен on 24.05.2022.
//

import UIKit

final class StockCell: UITableViewCell {
    
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
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textColor = .black
        
        return lbl
    }()
    
    private lazy var companyLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Amazon.com"
        lbl.font = .systemFont(ofSize: 15)
        lbl.textColor = .black
        
        return lbl
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubview() {
        [iconView, textView].forEach { view in
            contentView.addSubview(view)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.height.width.equalTo(52)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.left.equalTo(iconView.snp.right).offset(12)
            make.bottom.equalTo(contentView.snp.bottom).offset(-14)
            make.width.equalTo(74)
        }
        
        setupTextView()
    }
    
    private func setupTextView() {
        
        [symbolLabel, /*companyLabel*/].forEach { view in
            textView.addSubview(view)
        }

        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top)
            make.left.equalTo(textView.snp.left)
        }
        
//        companyLabel.snp.makeConstraints { make in
//            make.bottom.equalTo(textView.snp.bottom)
//            make.left.equalTo(textView.snp.left)
//        }
    }
}
