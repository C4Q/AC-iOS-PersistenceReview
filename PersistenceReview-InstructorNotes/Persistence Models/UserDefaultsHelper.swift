//
//  UserDefaultsHelper.swift
//  PersistenceReview-InstructorNotes
//
//  Created by C4Q  on 1/3/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    private init() {}
    static let manager = UserDefaultsHelper()
    let numberOfLoadsKey = "numberOfLoadedImages"
    let nameKey = "savedName"
    func incrementNumberOfLoadedImages() {
        let loadsSoFar = UserDefaults.standard.integer(forKey: numberOfLoadsKey)
        UserDefaults.standard.set(loadsSoFar + 1, forKey: numberOfLoadsKey)
    }
    func getNumberOfImageLoads() -> Int {
        return UserDefaults.standard.integer(forKey: numberOfLoadsKey)
    }
    func save(name: String) {
        UserDefaults.standard.setValue(name, forKey: nameKey)
    }
    func getSavedName() -> String? {
        return UserDefaults.standard.object(forKey: nameKey) as? String
    }
}
