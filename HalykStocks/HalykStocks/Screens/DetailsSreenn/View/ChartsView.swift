//
//  ChartsView.swift
//  HalykStocks
//
//  Created by Даурен on 08.06.2022.
//

import UIKit
import Charts

final class ChartsContainerView: UIView {
    
    private var chartsView: LineChartView = {
        let view = LineChartView()
        view.xAxis.drawLabelsEnabled = false
        view.leftAxis.enabled = false
        view.leftAxis.drawGridLinesEnabled = false
        view.rightAxis.enabled = false
        view.rightAxis.drawGridLinesEnabled = false
        view.backgroundColor = .white
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
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with isLoading: Bool) {
        isLoading ? loader.startAnimating() : loader.stopAnimating()
        loader.isHidden = !isLoading
        buttonsStackView.isHidden = isLoading
    }
    
    func configure(with model: DetailModel) {
        addButtons(for: model)
        setCharts(with: model.periods.first)
    }
    
    private func setupSubviews() {
        [chartsView, buttonsStackView, loader].forEach { view in
            addSubview(view)
        }
        
        chartsView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.79)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(chartsView.snp.bottom).offset(40)
            make.height.equalTo(45)
            make.bottom.equalToSuperview()
        }
        
        loader.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func addButtons(for model: DetailModel) {
        model.periods.enumerated().forEach { (index, period) in
            let button = UIButton()
            if period.name == "1Y" {
                button.backgroundColor = UIColor.black
                button.setTitle(period.name, for: .normal)
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = UIColor.buttonBackgroundColor
                button.setTitle(period.name, for: .normal)
                button.setTitleColor(.black, for: .normal)
            }
            button.tag = index
            button.titleLabel?.font = UIFont.customFont(name: .moserratBold, size: 12)
            button.layer.cornerRadius = 12
            button.addTarget(self, action: #selector(periodButtonTapped), for: .touchUpInside)
            button.layer.cornerCurve = .continuous
            buttonsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func  periodButtonTapped(sender: UIButton) {
        buttonsStackView.subviews.compactMap { $0 as? UIButton }.forEach {
            $0.backgroundColor = sender.tag == $0.tag ? .black : UIColor.buttonBackgroundColor
            $0.setTitleColor(sender.tag == $0.tag ? .white : .black, for: .normal)
        }
    }
    
    private func setCharts(with period: DetailModel.Period?) {
        guard let period = period else {
            return
        }

        var yValues = [ChartDataEntry]()
        for (index, value) in period.prices.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index + 1), y: value)
            yValues.append(dataEntry)
        }
        
        let lineDataSet = LineChartDataSet(entries: yValues, label: "")
        lineDataSet.fillColor = .lightGray
        lineDataSet.valueFont = .boldSystemFont(ofSize: 10)
        lineDataSet.valueTextColor = .white
        lineDataSet.drawFilledEnabled = true
        lineDataSet.circleRadius = 3.0
        lineDataSet.circleHoleRadius = 2.0
        
        chartsView.data = LineChartData(dataSets: [lineDataSet])
        chartsView.animate(xAxisDuration: 0.3, yAxisDuration: 0.2)
    }
}
