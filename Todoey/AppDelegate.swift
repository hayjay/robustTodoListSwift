//
//  AppDelegate.swift
//  Todoey
//
//  Created by Nurudeen Ajayi on 11/01/2020.
//  Copyright © 2020 Nurudeen Ajayi. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        //create brand new Realm DB
        do {
            _ = try Realm()
            
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }
}

