import Foundation

// MARK: - Weather Service Protocol
protocol WeatherServiceProtocol {
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse
}

// MARK: - Weather Service
final class WeatherService: WeatherServiceProtocol {
    private let apiKey = "59bb56e1b5934986984113445252305"
    private let baseURL = "https://api.weatherapi.com/v1"
    
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        let urlString = "\(baseURL)/forecast.json?q=\(city)&days=5&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
} 