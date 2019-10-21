//
//  HistoryViewController.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    enum SectionType {
        case translatedWord
    }
    let realmManager = RealmManager()
    let sections: [SectionType] = [.translatedWord]
    var translatedWords: [TranslatedWord?] = []
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.estimatedRowHeight = 45
            tableView.allowsSelection = true
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerNibModels(nibModels:
                [WordCardViewCellModel.self])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translatedWords = realmManager.loadFromRealm()
    }
    
    //MARK: - Private funcs
    
    private func configurateLanguage(_ language: String) -> String? {
        switch language {
        case "English":
            return "ENG"
        case "Russian":
            return "RUS"
        case "German":
            return "GER"
        case "French":
            return "FRN"
        default:
            return "ENG"
        }
    }
}

//MARK: - UITableViewDataSource
    
extension HistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .translatedWord:
            let translate = translatedWords[indexPath.row]
            let language = configurateLanguage((translate?.translationLanguage)!)
            model = WordCardViewCellModel(word: (translate?.translatableWord)!, language: language!)
        }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch  sectionType {
        case .translatedWord:
            return translatedWords.count
        }
    }
}
