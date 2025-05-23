// MARK: - Weather Utils
import Foundation

extension String {
    func toFormattedDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = inputFormatter.date(from: self) else { return self }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd.MM.yyyy"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputFormatter.string(from: date)
    }
}

extension Double {
    func kilometersPerHourToMetersPerSecond() -> Double {
        return self * 1000 / 3600 // конвертация из км/ч в м/с
    }
} 