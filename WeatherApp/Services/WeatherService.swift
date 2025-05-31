import Foundation
import Combine

// MARK: - Weather Service Protocol
protocol WeatherServiceProtocol {
    func fetchWeatherForecast(for city: String) -> AnyPublisher<WeatherResponse, Error>
}

// MARK: - Weather Service
final class WeatherService: WeatherServiceProtocol {
    private let apiKey = "59bb56e1b5934986984113445252305"
    private let baseURL = "https://api.weatherapi.com/v1"
    
    func fetchWeatherForecast(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        let urlString = "\(baseURL)/forecast.json?q=\(city)&days=5&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
} 