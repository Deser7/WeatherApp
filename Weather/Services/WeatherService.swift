// MARK: - Weather Service
import Foundation

final class WeatherService {
    // MARK: - Properties
    private let apiKey = "59bb56e1b5934986984113445252305"
    private let baseURL = "https://api.weatherapi.com/v1"
    
    // MARK: - Private Properties
    private lazy var decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // MARK: - Public Methods
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        let urlString = "\(baseURL)/forecast.json?q=\(city)&days=5&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode(WeatherResponse.self, from: data)
    }
} 
