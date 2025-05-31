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
            return "Incorrect city name"
        case .networkError:
            return "Network error. Check your internet connection."
        case .invalidResponse:
            return "Incorrect response from the server."
        case .decodingError:
            return "Data processing error."
        }
    }
} 
// MARK: - Weather Service Protocol
protocol WeatherServiceProtocol {
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse
}

// MARK: - Weather Service
final class WeatherService: WeatherServiceProtocol {
    private let apiKey = "59bb56e1b5934986984113445252305"
    private let baseURL = "https://api.weatherapi.com/v1"
    
    // MARK: - Public Methods
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        // Проверяем, что город не пустой
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw WeatherError.invalidCity
        }
        
        // Формируем URL
        let urlString = "\(baseURL)/forecast.json?key=\(apiKey)&q=\(city)&days=5&aqi=no&alerts=no"
        guard let url = URL(string: urlString) else {
            throw WeatherError.invalidResponse
        }
        
        do {
            // Выполняем запрос
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Проверяем статус ответа
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw WeatherError.networkError
            }
            
            // Декодируем ответ
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(WeatherResponse.self, from: data)
            } catch {
                throw WeatherError.decodingError
            }
        } catch let error as WeatherError {
            throw error
        } catch {
            throw WeatherError.networkError
        }
    }
} 
