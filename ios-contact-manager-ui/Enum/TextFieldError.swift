//
//  ErrorEnum.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 14/01/2024.
//

import Foundation

enum TextFieldError: Error {
    case ageTextFieldError
    case nameTextFieldError
    case phoneNumberFieldError
    
    var ErrorMessage: String {
        switch self {
        case .ageTextFieldError:
            "입력한 나이 정보가 잘못되었습니다."
        case .nameTextFieldError:
            "입력한 이름 정보가 잘못되었습니다."
        case .phoneNumberFieldError:
            "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
