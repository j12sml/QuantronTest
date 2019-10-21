//
//  Client.swift
//  QuantronTest
//
//  Created by Alex Alekseev on 16.10.2019.
//  Copyright © 2019 Alexandr Kostiukevich. All rights reserved.
//

import Foundation
import Kanna

final class Client {
    
    func uploadURL(l1: String, l2: String, text: String, completion: @escaping ([String]) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "multitran.com"
        urlComponents.path = "/m.exe"
        urlComponents.queryItems = [
            URLQueryItem(name: "l1", value: l1),
            URLQueryItem(name: "l2", value: l2),
            URLQueryItem(name: "CL", value: "1"),
            URLQueryItem(name: "s", value: text)]
        let url = urlComponents.url!
        parseHTML(url: url, completion: completion)
        print(url)
    }
    
    //MARK: - Private funcs
    
    private func parseHTML(url: URL, completion: @escaping ([String]) -> Void) {
        var translateArray: [String] = []
        if let doc = try? HTML(url: url, encoding: .utf8) {
            for element in doc.xpath("//td") {
                if element["class"] == "trans" && element.text != nil {
                    translateArray.append(element.text!)
                }
            }
        }
        completion(translateArray)
    }
}

