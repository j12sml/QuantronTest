//
//  WordCardCellViewModel.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//


import UIKit

struct WordCardViewCellModel {
    let word: String
    let language: String
}

extension WordCardViewCellModel: CellViewModel {
    func setup(cell: WordCardTableViewCell) {
        cell.WordLabel.text = word
        cell.LanguageLabel.text = language
    }
}
