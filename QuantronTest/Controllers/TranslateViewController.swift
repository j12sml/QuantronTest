//
//  ViewController.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    let realmManager = RealmManager()
    var translatableLanguage: String? = "Russian"
    var translationLanguage: String? = "English"
    @IBOutlet var translatableLanguageButton: UIButton!
    @IBOutlet var translationLanguageButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func firstLanguage(_ sender: Any) {
        if let secondLanguage = translationLanguage {
        pushLanguageViewController(setLanguageSelect: true, setValueOfSecondLanguage: secondLanguage)
        }
    }
    
    @IBAction func secondLanguage(_ sender: Any) {
        if let secondLanguage = translatableLanguage {
        pushLanguageViewController(setLanguageSelect: false, setValueOfSecondLanguage: secondLanguage)
        }
    }
    
    @IBAction func swapLanguages(_ sender: Any) {
        translatableLanguage = translatableLanguageButton.titleLabel?.text
        translationLanguage = translationLanguageButton.titleLabel?.text
        translatableLanguageButton.setTitle(translationLanguage, for: .normal)
        translationLanguageButton.setTitle(translatableLanguage, for: .normal)
        let swapValue = translatableLanguage
        translatableLanguage = translationLanguage
        translationLanguage = swapValue
    }
    
    @IBAction func findButton(_ sender: Any) {
        guard let text = searchTextField.text else { return }
        if text == "" {
            self.showMessageAlert(title: "Hey, hey, wait!", message: "Please, write something, I cant translate void", buttonTitle: "OK")
        }
        if let wordCardVC = UIStoryboard.instantiateViewController(.wordCardVC) as? WordCardViewController {
            let translatedWord = TranslatedWord()
            translatedWord.translatableWord = text
            translatedWord.translationLanguage = translationLanguage!
            realmManager.saveToRealm(object: translatedWord)
            wordCardVC.textToTranslate = text
            wordCardVC.translatableLanguage = translatableLanguage
            wordCardVC.translationLanguage = translationLanguage
            self.navigationController?.pushViewController(wordCardVC, animated: true)
        }
    }
    
    @IBAction func checkHistory(_ sender: Any) {
        if let historyVC = UIStoryboard.instantiateViewController(.historyVC) as? HistoryViewController {
            self.navigationController?.pushViewController(historyVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Private funcs
    
    private func pushLanguageViewController(setLanguageSelect: Bool, setValueOfSecondLanguage: String) {
        if let languagesVC = UIStoryboard.instantiateViewController(.languageVC) as? LanguagesViewController {
            languagesVC.selectFirstLanguage = setLanguageSelect
            languagesVC.secondLanguageValue = setValueOfSecondLanguage
            self.navigationController?.pushViewController(languagesVC, animated: true)
        }
    }
}

