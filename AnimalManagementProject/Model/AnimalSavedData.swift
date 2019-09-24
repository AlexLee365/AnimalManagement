//
//  AnimalSavedData.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/24.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

class AnimalSavedData {
    static var singleton = AnimalSavedData()
    
    var animalArray = [Animal]()
}
