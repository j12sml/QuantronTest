//
//  TranslateResultCellViewModel.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

struct TranslateResultViewCellModel {
    let translate: String
}

extension TranslateResultViewCellModel: CellViewModel {
    func setup(cell: TranslateResultTableViewCell) {
        cell.TranslateLabel.text = translate
    }
}
