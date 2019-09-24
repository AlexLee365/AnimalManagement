//
//  AnimalListView.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/23.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

protocol AnimalListViewDelegate: class {
    func pushAddAnimalVC()
    func showCyringAlert(selectedIndex: IndexPath)
}

class AnimalListView: UIView {

    private let topGuideView = UIView()
    private let topGuideAnimaltypeLabel = UILabel()
    private let topGuideAnimalNameLabel = UILabel()
    
    private let messageLabel = UILabel()
    
    private let tableView = UITableView()
    private let plusButton = UIButton()
    
    var animalArray = [Animal]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if self.animalArray.count > 0 {
                    self.sendSubviewToBack(self.messageLabel)
                }
            }
        }
    }
    weak var delegate: AnimalListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAutoLayout()
        configureViewsOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setAutoLayout() {
        self.addSubview(topGuideView)
        topGuideView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        topGuideView.addSubview(topGuideAnimaltypeLabel)
        topGuideAnimaltypeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topGuideView.snp.leading).offset(UIScreen.main.bounds.width/4)
            make.centerY.equalToSuperview()
        }
        
        topGuideView.addSubview(topGuideAnimalNameLabel)
        topGuideAnimalNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topGuideAnimaltypeLabel.snp.centerX).offset(UIScreen.main.bounds.width/8*3 + "동물 타입".textSize(15, .semibold).width/2 - "이름".textSize(15, .semibold).width/2)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(topGuideView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topGuideView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        self.addSubview(plusButton)
        plusButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-20)
            make.width.height.equalTo(60)
        }
        
        self.bringSubviewToFront(topGuideView)
    }
    
    private func configureViewsOptions() {
        topGuideAnimaltypeLabel.text = "동물 타입"
        topGuideAnimaltypeLabel.textColor = .black
        topGuideAnimaltypeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        topGuideAnimalNameLabel.text = "이름"
        topGuideAnimalNameLabel.textColor = .black
        topGuideAnimalNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        topGuideView.backgroundColor = .white
        topGuideView.layer.masksToBounds = false
        topGuideView.layer.shadowOpacity = 0.1
        topGuideView.layer.shadowOffset = CGSize(width: 0, height: 3)
        topGuideView.layer.shadowRadius = 5
        topGuideView.layer.shadowColor = UIColor.gray.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.register(AnimalListTableViewCell.self, forCellReuseIdentifier: AnimalListTableViewCell.identifier)
        tableView.separatorInset = .init(top: 0, left: 1000, bottom: 0, right: 0)
        
        messageLabel.backgroundColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = UIColor(red:0.10, green:0.74, blue:0.61, alpha:0.7)
        messageLabel.font = .systemFont(ofSize: 15, weight: .bold)
        messageLabel.text = "등록된 동물이 없습니다.\n새로운 동물을 추가해보세요!"
        
        plusButton.setImage(UIImage(named: "plusButton"), for: .normal)
        plusButton.imageEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        plusButton.addTarget(self, action: #selector(plusButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc private func plusButtonDidTap(_ sender: UIButton) {
        delegate?.pushAddAnimalVC()
    }
}

extension AnimalListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalArray.count
//        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let animalListCell = tableView.dequeueReusableCell(withIdentifier: AnimalListTableViewCell.identifier, for: indexPath) as! AnimalListTableViewCell
        animalListCell.setData(animal: animalArray[indexPath.row])
        
        return animalListCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == animalArray.count-1 {
            cell.separatorInset = .init(top: 0, left: 1000, bottom: 0, right: 0)
        } else {
            cell.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard animalArray[indexPath.row].isCrying else {
            print("울음소리가 없는 동물입니다.")
            return
        }
        delegate?.showCyringAlert(selectedIndex: indexPath)
    }
    
    
    
}
