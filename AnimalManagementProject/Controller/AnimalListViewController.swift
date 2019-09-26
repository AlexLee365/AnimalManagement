//
//  AnimalListViewController.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/23.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit
import SnapKit

class AnimalListViewController: UIViewController {
    
    // MARK: - UI Properties
    private let animalListView = AnimalListView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animalListView.animalArray = AnimalSavedData.singleton.animalArray
    }
    
    private func setAutoLayout() {
        view.addSubview(animalListView)
        animalListView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureViewsOptions() {
        title = "동물 관리"
        animalListView.delegate = self
    }
}

extension AnimalListViewController: AnimalListViewDelegate {
    func showCyringAlert(selectedIndex: IndexPath) {
        let selectedAnimal = animalListView.animalArray[selectedIndex.row]
        
        let alert = UIAlertController(title: "\(selectedAnimal.type) '\(selectedAnimal.name)'", message: selectedAnimal.cryingSound, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default) { _ in }
        
        alert.addAction(action1)
        present(alert, animated: true)
    }
    
    func pushAddAnimalVC() {
        let addAnimalVC = AddAnimalViewController()
        navigationController?.pushViewController(addAnimalVC, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .gray
    }
}
