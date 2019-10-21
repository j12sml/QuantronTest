//
//  TranslatedWord.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 21.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import Foundation
import RealmSwift

class TranslatedWord: Object {
    @objc dynamic var translatableWord = ""
    @objc dynamic var translationLanguage = ""
}
