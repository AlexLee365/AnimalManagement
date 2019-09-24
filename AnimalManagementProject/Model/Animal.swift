//
//  Animal.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/24.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import Foundation

protocol Animal {
    var type: String { get }
    var name: String { get set }
    var isCrying: Bool { get }
    var cryingSound: String { get }

    init(name: String)
}

struct Cat: Animal {
    var type: String
    var name: String
    var isCrying: Bool
    var cryingSound: String

    init(name: String) {
        type = "고양이"
        self.name = name
        isCrying = true
        cryingSound = "야옹야옹"
    }
}

struct Dog: Animal {
    var type: String
    var name: String
    var isCrying: Bool
    var cryingSound: String

    init(name: String) {
        type = "강아지"
        self.name = name
        isCrying = true
        cryingSound = "멍멍"
    }
}

struct Parrot: Animal {
    var type: String
    var name: String
    var isCrying: Bool
    var cryingSound: String

    init(name: String) {
        type = "앵무새"
        self.name = name
        isCrying = true
        cryingSound = "안녕하세요"
    }
}

struct Lizard: Animal {
    var type: String
    var name: String
    var isCrying: Bool
    var cryingSound: String

    init(name: String) {
        type = "도마뱀"
        self.name = name
        isCrying = false
        cryingSound = ""
    }
}

