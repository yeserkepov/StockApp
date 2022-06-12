//
//  SearchView.swift
//  HalykStocks
//
//  Created by Даурен on 10.06.2022.
//

import UIKit
import SnapKit

final class SearchView: UIView, UITextFieldDelegate {
    weak var delegate: SearchTextFieldDelegate?
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "Search..."
        textField.font = UIFont.customFont(name: .moserratMedium, size: 18)
        textField.tintColor = .black
        textField.returnKeyType = .go
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(searchTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var clearSearchButton: UIButton  = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "delete.left"), for: .normal)
        btn.addTarget(self, action: #selector(clearSearchButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var searchViewItems: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 20
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func searchTextFieldChanged(sender: UITextField) {
        delegate?.textDidChange(with: sender.text)
    }

    @objc private func clearSearchButtonTapped() {
        searchTextField.text = ""
        searchTextFieldChanged(sender: searchTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    private func setupView() {
        addSubview(searchViewItems)
        
        searchViewItems.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [searchTextField, clearSearchButton].forEach { searchViewItems.addSubview($0) }
        
        searchTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.right.equalTo(clearSearchButton.snp.left).offset(-18)
        }
        
        clearSearchButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(16)
        }
    }
}
