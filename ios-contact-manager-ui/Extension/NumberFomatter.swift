import Foundation

extension String {
    
    func formatPhoneNumber() -> String {
        var formatText = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        guard !formatText.isEmpty else {
            return ""
        }
        
        let hyphen: Character = "-"
        
        if formatText.hasPrefix("02") {
            // 서울 지역번호 ("02")에 대한 처리
            switch formatText.count {
            case 3...5:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
            case 6...9:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
                formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: 6 - formatText.count))
            case 10:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
                formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: -4))
            default:
                break
            }
        } else if formatText.hasPrefix("0") {
            switch formatText.count {
            case 4...6:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
            case 7...10:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
                formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: 7 - formatText.count))
            case 11:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 3))
                formatText.insert(hyphen, at: formatText.index(formatText.endIndex, offsetBy: -4))
            default:
                break
            }
        } else {
            switch formatText.count {
            case 1...2:
                break
            case 3...4:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
            case 5:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 5))
            case 6...7:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 6))
            case 8...10:
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 2))
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 6))
                formatText.insert(hyphen, at: formatText.index(formatText.startIndex, offsetBy: 10))
            default:
                break
            }
        }
        return formatText
    }
}

