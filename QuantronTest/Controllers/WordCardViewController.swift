//
//  WordCardViewController.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import UIKit

class WordCardViewController: UIViewController {
    
    enum SectionType {
        case info, translate
    }
    enum LanguageType {
        case request, abbreviation
    }
    let client = Client()
    let sections: [SectionType] = [.info, .translate]
    let languageType: [LanguageType] = [.request, .abbreviation]
    var textToTranslate: String?
    var translatableLanguage: String?
    var translationLanguage: String?
    var translatedText: [String?] = []
    @IBOutlet var tableView: UITableView!{
        didSet {
            tableView.dataSource = self
            tableView.registerNibModels(nibModels:
                [WordCardViewCellModel.self, TranslateResultViewCellModel.self])
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    //Private funcs
    
    private func uploadData(){
        DispatchQueue.global(qos: .userInitiated).async {
            guard let translatableLanguage = self.translatableLanguage,
                let translationLanguage = self.translationLanguage,
                let textToTranslate = self.textToTranslate else {
                    return
            }
            if let firstLanguageWithNumber = self.configurateLanguage(translatableLanguage, prepareForUse: .request),
                let secondLanguageWithNumber = self.configurateLanguage(translationLanguage, prepareForUse: .request) {
                self.client.uploadURL(l1: firstLanguageWithNumber, l2: secondLanguageWithNumber, text: textToTranslate) { [weak self] data in
                    self?.translatedText = data
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
                if self.translatedText == [] {
                    DispatchQueue.main.async {
                        self.showMessageAlert(title: "Error", message: "No results, check your request and try again", buttonTitle: "OK")
                        return
                    }
                }
            }
        }
        
    }
    
    private func configurateLanguage(_ language: String, prepareForUse: LanguageType) -> String? {
        switch prepareForUse {
        case .request:
            switch language {
            case "English":
                return "1"
            case "Russian":
                return "2"
            case "German":
                return "3"
            case "French":
                return "4"
            default:
                return "1"
            }
        case .abbreviation:
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
}

//MARK: - UITableViewDataSource

extension WordCardViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        let model: CellViewAnyModel
        switch sectionType {
        case .info:
            let language = configurateLanguage(translationLanguage!, prepareForUse: .abbreviation)
            model = WordCardViewCellModel(word: textToTranslate!, language: language!)
        case .translate:
            let translate = translatedText[indexPath.row]
            model = TranslateResultViewCellModel(translate: "\(indexPath.row + 1)." + " " + translate!)
        }
        return tableView.dequeueReusableCell(withModel: model, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch  sectionType {
        case .info:
            return 1
        case .translate:
            return translatedText.count
        }
    }
}
