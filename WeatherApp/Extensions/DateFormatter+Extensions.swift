import Foundation

// MARK: - Date Formatter Extension
extension DateFormatter {
    static let weatherDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}

// MARK: - String Extension
extension String {
    var formattedDate: String {
        guard let date = DateFormatter.weatherDateFormatter.date(from: self) else {
            return self
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}

// MARK: - Double Extension
extension Double {
    var kilometersPerHourToMetersPerSecond: Double {
        return self * 1000 / 3600
    }
} 