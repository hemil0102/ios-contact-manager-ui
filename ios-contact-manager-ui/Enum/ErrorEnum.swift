//
//  ErrorEnum.swift
//  ios-contact-manager-ui
//
//  Created by 권태호 on 14/01/2024.
//

import Foundation

enum ErrorEnum: Error {
    case ageTextFeildError
    case nameTextFeildError
    case phoneNumberFeildError
    
    var ErrorMessage: String {
        switch self {
        case .ageTextFeildError:
            "입력한 이름 정보가 잘못되었습니다."
        case .nameTextFeildError:
            "입력한 나이 정보가 잘못되었습니다."
        case .phoneNumberFeildError:
            "입력한 연락처 정보가 잘못되었습니다."
        }
    }
}
