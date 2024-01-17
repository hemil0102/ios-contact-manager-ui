//
//  JsonParsingError.swift
//  ios-contact-manager-ui
//
//  Created by Harry Ho on 1/9/24.
//

import UIKit

enum JsonParsingError: Error {
    case pathError
    case stringConversionError
    case encodingError
    case decodingError
    case fileLoadError
    

}


