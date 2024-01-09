//
//  JsonDecoder.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/9/24.
//

import UIKit

struct JsonDecoder<Element: Codable> {
    func loadData(from fileName: String, of fileType: String) throws -> Element {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else { throw JsonParsingError.pathError }
        
        var content: String = ""
        do {
            content = try String(contentsOfFile: filePath)
        } catch {
            print("Error")
        }
        guard let data = content.data(using: .utf8) else { throw JsonParsingError.decodeError }
        guard let jsonData = try? JSONDecoder().decode(Element.self, from: data) else { throw JsonParsingError.decodeError }
        
        return jsonData
    }
}
