//
//  UIViewController + Alert.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 18.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessageAlert(title: String?, message: String? = nil,
                          buttonTitle: String? = "Ок".localized, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            if let action = action { action() }
        })
        self.present(alert, animated: true, completion: nil)
    }
}
