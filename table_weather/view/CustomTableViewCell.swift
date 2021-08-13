//
//  CustomTableViewCell.swift
//  table_weather
//
//  Created by Petar Perich on 10.08.2021.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let nameLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.textAlignment = .center
        
        return label
    }()
    
    let conditionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.textAlignment = .center
        
        return label
        
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints  = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(nameLabel)
        horizontalStackView.addArrangedSubview(conditionsLabel)
        horizontalStackView.addArrangedSubview(temperatureLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        horizontalStackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().inset(2)
            maker.trailing.equalToSuperview().inset(2)
        }
        
    }
    
    
}
