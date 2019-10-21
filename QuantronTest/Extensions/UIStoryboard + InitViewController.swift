//
//  UIStoryboard + InitViewController.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 17.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func instantiateViewController(_ viewControllerName: ViewControllerName) -> UIViewController? {
        return viewControllerName.currentVC
    }
    
    enum ViewControllerName {
        case translateVC, languageVC, wordCardVC, historyVC
        var currentVC: UIViewController? {
            switch self {
            case .translateVC:
                return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TranslateViewController")
            case .languageVC:
                return UIStoryboard(name: "Languages", bundle: nil).instantiateViewController(withIdentifier: "LanguagesViewController")
            case .wordCardVC:
                return UIStoryboard(name: "WordCard", bundle: nil).instantiateViewController(withIdentifier: "WordCardViewController")
            case .historyVC:
                return UIStoryboard(name: "History", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController")
            }
        }
    }
}
