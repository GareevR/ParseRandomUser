//
//  UserInfoViewCell.swift
//  ParseRandomUser
//
//  Created by Ринат Гареев on 15.01.2022.
//

import UIKit

class UserInfoViewCell: UICollectionViewCell {
    
    private let keyLabel = UILabel()
    
    private let valueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupKeyLabel()
        setupValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupKeyLabel() {
        addSubview(keyLabel)
        
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        keyLabel.textAlignment = .left
        keyLabel.font = UIFont(name: "Helvetica-Bold", size: 20)
        keyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15).isActive = true
        keyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupValueLabel() {
        addSubview(valueLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.textAlignment = .left
        
        valueLabel.font = UIFont(name: "Helvetica", size: 15)
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 15).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    func setValues(key: String, value: String) {
        valueLabel.text = value
        keyLabel.text = key
    }
}
