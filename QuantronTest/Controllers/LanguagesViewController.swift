//
//  LanguageViewController.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

class LanguagesViewController: UIViewController {
    
    enum SectionType {
        case language
    }
    var selectFirstLanguage: Bool?
    var secondLanguageValue: String?
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.estimatedRowHeight = 45
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerNibModels(nibModels:
                [LanguageViewCellModel.self])
        }
    }
    let sections: [SectionType] = [.language]
    let languages = ["Russian", "English", "German", "French"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - UITableViewDataSource

extension LanguagesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .language:
            let language = languages[indexPath.row]
            model = LanguageViewCellModel(language: language)
        }
        return  tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch  sectionType {
        case .language:
            return languages.count
        }
    }
}

//MARK: - UITableViewDelegate

extension LanguagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let translateVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TranslateViewController") as? TranslateViewController {
            if selectFirstLanguage == true {
                translateVC.translatableLanguageButton.setTitle(languages[indexPath.row], for: .normal)
                translateVC.translatableLanguage = languages[indexPath.row]
                translateVC.translationLanguage = secondLanguageValue
                translateVC.translationLanguageButton.setTitle(secondLanguageValue, for: .normal)
            } else {
                translateVC.translationLanguageButton.setTitle(languages[indexPath.row], for: .normal)
                translateVC.translationLanguage = languages[indexPath.row]
                translateVC.translatableLanguage = secondLanguageValue
                translateVC.translatableLanguageButton.setTitle(secondLanguageValue, for: .normal)
            }
            self.navigationController?.pushViewController(translateVC, animated: true)
        }
    }
}

