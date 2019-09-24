//
//  AnimalListTableViewCell.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/24.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AnimalListTableViewCell: UITableViewCell {
    static let identifier = "AnimalListTableViewCell"
    let animalTypeLabel = UILabel()
    let animalNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(animalTypeLabel)
        animalTypeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.leading).offset(UIScreen.main.bounds.width/4)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(animalNameLabel)
        animalNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(animalTypeLabel.snp.centerX).offset(UIScreen.main.bounds.width/8*3 + "동물 타입".textSize(15, .semibold).width/2 - "이름".textSize(15, .semibold).width/2)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureViewsOptions() {
        self.selectionStyle = .none
        
        animalTypeLabel.font = .systemFont(ofSize: 13, weight: .light)
        animalTypeLabel.textColor = .black
        
        animalNameLabel.font = .systemFont(ofSize: 13, weight: .light)
        animalNameLabel.textColor = .black
    }

    func setData(animal: Animal) {
        animalTypeLabel.text = animal.type
        animalNameLabel.text = animal.name
    }

}
