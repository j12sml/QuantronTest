//
//  RealmManager.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 21.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private let realm = try! Realm()
    
    func saveToRealm(object: Object) {
        do {
            realm.beginWrite()
            checkCountOfObjects()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    func loadFromRealm() -> [TranslatedWord?] {
        do {
            let data = realm.objects(TranslatedWord.self)
            return Array(data)
        }
    }
    
    func checkCountOfObjects() {
        let data = realm.objects(TranslatedWord.self)
        if data.count == 5 {
            realm.delete(data.last!)
        }
    }
}

