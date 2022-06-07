//
//  ChartsView.swift
//  HalykStocks
//
//  Created by Даурен on 08.06.2022.
//

import UIKit

final class ChartsContainerView: UIView {
    
    private lazy var chartsView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        addButtons(for: ["W", "M", "6M", "1Y"])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        [chartsView, buttonsStackView].forEach { view in
            addSubview(view)
        }
        
        chartsView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(chartsView.snp.bottom).offset(40)
            make.height.equalTo(45)
            make.bottom.equalToSuperview()
        }
    }
    
    private func addButtons(for titles: [String]) {
        titles.enumerated().forEach { (index, title) in
            let button = UIButton()
            button.tag = index
            button.backgroundColor = UIColor.lightGray
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.customFont(name: .moserratBold, size: 12)
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
            button.layer.cornerCurve = .continuous
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func  periodButtonTapped(sender: UIButton) {
        print("Button index -", sender.tag)
    }
}

