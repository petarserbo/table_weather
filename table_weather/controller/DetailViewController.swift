//
//  DetailViewController.swift
//  table_weather
//
//  Created by Petar Perich on 11.08.2021.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    var nameDetailInfo = ""
    var conditionsDetailInfo = ""
    var temperatureDetailInfo = ""
    var windDetailInfo = ""
    var pressureDetailInfo = ""
    
    let verticallStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let secondVerticallStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    let nameDetailLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        
        return label
    }()
    
    let conditionsDetailLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        
        return label
    }()
    
    let temperatureDetailLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        
        return label
    }()
    
    let windDetailLabel: UILabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let pressureDetailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(verticallStackView)
        view.addSubview(secondVerticallStackView)
        verticallStackView.addArrangedSubview(nameDetailLabel)
        verticallStackView.addArrangedSubview(conditionsDetailLabel)
        verticallStackView.addArrangedSubview(temperatureDetailLabel)
        secondVerticallStackView.addArrangedSubview(windDetailLabel)
        secondVerticallStackView.addArrangedSubview(pressureDetailLabel)
        
        
        nameDetailLabel.text = nameDetailInfo
        conditionsDetailLabel.text = conditionsDetailInfo
        temperatureDetailLabel.text = temperatureDetailInfo
        windDetailLabel.text = windDetailInfo
        pressureDetailLabel.text = pressureDetailInfo
        view.backgroundColor = .white
        
    }
    
    
    override func viewDidLayoutSubviews() {
        
        verticallStackView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().inset(150)
            maker.centerX.equalToSuperview()
            
        }
        
        secondVerticallStackView.snp.makeConstraints { (maker) in
            maker.top.equalTo(temperatureDetailLabel).inset(100)
            maker.centerX.equalToSuperview()
        }
        
        
    }
    
    
}
