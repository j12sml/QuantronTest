//
//  LanguageCellViewModel.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

struct LanguageViewCellModel {
    let language: String
}

extension LanguageViewCellModel: CellViewModel {
    func setup(cell: LanguageTableViewCell) {
        cell.LanguageLabel.text = language
    }
}
