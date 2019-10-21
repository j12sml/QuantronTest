//
//  String + Localized.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 18.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
