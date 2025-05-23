// MARK: - Localization Utils
import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }
}

extension String {
    func localizedWeatherCondition() -> String {
        switch self.lowercased() {
        case "sunny", "clear":
            return "weather.condition.sunny".localized
        case "partly_cloudy":
            return "weather.condition.partly_cloudy".localized
        case "cloudy", "overcast":
            return "weather.condition.cloudy".localized
        case "rain", "light rain", "moderate rain", "heavy rain":
            return "weather.condition.rain".localized
        case "snow", "light snow", "moderate snow", "heavy snow":
            return "weather.condition.snow".localized
        case "thunder", "thunderstorm":
            return "weather.condition.thunder".localized
        case "fog":
            return "weather.condition.fog".localized
        case "mist":
            return "weather.condition.mist".localized
        default:
            return self
        }
    }
} 
