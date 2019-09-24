//
//  AddAnimalViewController.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/23.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

class AddAnimalViewController: UIViewController {
    private let animalTypeLabel = UILabel()
    private let animalTypeTextField = UITextField()
    private let animalTypePickerView = UIPickerView()
    private let downSideImageView = UIImageView()
    
    private let animalNameLabel = UILabel()
    private let animalNameTextField = UITextField()
    
    private let okButton = UIButton()
    
    private let animalTypeArray = ["강아지", "고양이", "앵무새", "도마뱀"]
    private var animalTypeSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAutoLayout()
        configureViewsOptions()
    }
    
    private func setAutoLayout() {
        view.addSubview(animalTypeLabel)
        animalTypeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-70)
            make.centerY.equalToSuperview().offset(-50)
        }
        
        view.addSubview(animalTypeTextField)
        animalTypeTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(animalTypeLabel.snp.trailing).offset(40)
            make.centerY.equalTo(animalTypeLabel.snp.centerY)
            make.width.equalTo(110)
            make.height.equalTo(30)
        }
        
        view.addSubview(downSideImageView)
        downSideImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(10)
            make.centerX.equalTo(animalTypeTextField.snp.trailing).offset(-5)
            make.centerY.equalTo(animalTypeTextField.snp.centerY).offset(-1)
        }
        
        view.addSubview(animalNameLabel)
        animalNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(animalTypeLabel.snp.centerX)
            make.top.equalTo(animalTypeLabel.snp.bottom).offset(40)
        }
        
        
        view.addSubview(animalNameTextField)
        animalNameTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(animalTypeTextField.snp.centerX).offset(10)
            make.centerY.equalTo(animalNameLabel.snp.centerY)
            make.width.equalTo(130)
            make.height.equalTo(30)
        }
        
        view.addSubview(okButton)
        okButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(animalNameLabel.snp.bottom).offset(60)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    private func configureViewsOptions() {
        title = "동물 추가"
        view.backgroundColor = .white
        
        animalTypeLabel.text = "동물 타입"
        animalTypeLabel.textColor = .black
        animalTypeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        animalTypePickerView.dataSource = self
        animalTypePickerView.delegate = self
        animalTypePickerView.backgroundColor = .white
        
        animalTypeTextField.delegate = self
        animalTypeTextField.inputView = animalTypePickerView
        animalTypeTextField.text = "선택하세요"
        animalTypeTextField.font = .systemFont(ofSize: 15)
        animalTypeTextField.tintColor = .clear
        animalTypeTextField.textAlignment = .center
        
        downSideImageView.image = UIImage(named: "downSideIcon")
        
        animalNameLabel.text = "동물 이름"
        animalNameLabel.textColor = .black
        animalNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        animalNameTextField.delegate = self
        animalNameTextField.borderStyle = .roundedRect
        animalNameTextField.textAlignment = .center
        animalNameTextField.font = .systemFont(ofSize: 15)
        animalNameTextField.autocorrectionType = .no
        animalNameTextField.autocapitalizationType = .none
        
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.black, for: .normal)
        okButton.titleLabel?.font = .systemFont(ofSize: 12)
        okButton.backgroundColor = UIColor(red:0.10, green:0.74, blue:0.61, alpha:1.0)
        okButton.layer.masksToBounds = true
        okButton.layer.cornerRadius = 5
        okButton.addTarget(self, action: #selector(okButtonDidTap), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func okButtonDidTap() {
        guard animalTypeSelected && animalNameTextField.hasText else {
            makeAlert(title: "메세지", message: "동물 타입과 이름을 확인해주세요")
            return
        }
        
        guard animalNameTextField.text?.count ?? 0 < 10 else {
            makeAlert(title: "메세지", message: "동물 이름은 10자 이내로 입력해주세요")
            return
        }
        
        let animalName = animalNameTextField.text ?? ""
        var animal: Animal?
        
        switch animalTypePickerView.selectedRow(inComponent: 0) {
        case 0:
            animal = Dog(name: animalName)
        case 1:
            animal = Cat(name: animalName)
        case 2:
            animal = Parrot(name: animalName)
        case 3:
            animal = Lizard(name: animalName)
        default: break
        }
        
        if let animal = animal {
            AnimalSavedData.singleton.animalArray.append(animal)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "OK", style: .default) { _ in }
        alert.addAction(action1)
        present(alert, animated: true)
    }
}


extension AddAnimalViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animalTypeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animalTypeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        animalTypeTextField.text = animalTypeArray[row]
    }
}

extension AddAnimalViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == animalTypeTextField {
            animalTypeSelected = true
            textField.text = animalTypeArray[animalTypePickerView.selectedRow(inComponent: 0)]
        }
        textField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == animalTypeTextField {
            animalTypeTextField.resignFirstResponder()
            return false
        }
        
        
        return true
    }
}
