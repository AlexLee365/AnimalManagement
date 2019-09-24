//
//  AppDelegate.swift
//  AnimalManagementProject
//
//  Created by 행복한 개발자 on 2019/09/23.
//  Copyright © 2019 Alex Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let animalListVC = AnimalListViewController()
        let naviController = UINavigationController(rootViewController: animalListVC)
        
        loadSavedDataWhenStarting()
        
        window?.rootViewController = naviController
        window?.makeKeyAndVisible()
    
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveDataBeforeTerminating()
    }
    
    private func loadSavedDataWhenStarting() {
        guard let data = UserDefaults.standard.object(forKey: "SavedAnimalData") as? [[String: Any]] else {
            print("get userDefault Data Failed")
            return
        }
        
        let savedAnimalArray: [Animal?] = data.map{
            guard let type = $0["type"] as? String
                , let name = $0["name"] as? String else {
                    print("animal convert error")
                    return nil
            }
            
            switch type {
            case "고양이":
                return Cat(name: name)
            case "강아지":
                return Dog(name: name)
            case "앵무새":
                return Parrot(name: name)
            case "도마뱀":
                return Lizard(name: name)
            default :
                return nil
            }
        }
        
        AnimalSavedData.singleton.animalArray = savedAnimalArray.compactMap{$0}
    }
    
    private func saveDataBeforeTerminating() {
        let savingData = AnimalSavedData.singleton.animalArray.map {
            [ "type": $0.type,
              "name": $0.name
            ]
        }
        UserDefaults.standard.set(savingData, forKey: "SavedAnimalData")
    }
}

