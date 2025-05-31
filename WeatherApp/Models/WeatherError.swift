import Foundation

// MARK: - Weather Error
enum WeatherError: LocalizedError {
    case invalidCity
    case networkError
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "Некорректное название города"
        case .networkError:
            return "Ошибка сети. Проверьте подключение к интернету"
        case .invalidResponse:
            return "Некорректный ответ от сервера"
        case .decodingError:
            return "Ошибка обработки данных"
        }
    }
} 