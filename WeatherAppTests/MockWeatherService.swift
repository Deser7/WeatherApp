import Foundation
@testable import WeatherApp

// MARK: - Mock Weather Service
final class MockWeatherService: WeatherServiceProtocol {
    // MARK: - Properties
    var shouldThrowError = false
    var mockResponse: WeatherResponse?
    
    // MARK: - Public Methods
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        
        if let mockResponse = mockResponse {
            return mockResponse
        }
        
        // Создаем тестовые данные
        return WeatherResponse(
            forecast: Forecast(
                forecastday: [
                    ForecastDay(
                        date: "2024-03-20",
                        day: Day(
                            maxtempC: 20,
                            mintempC: 10,
                            avgtempC: 15,
                            maxwindKph: 15,
                            avghumidity: 60,
                            condition: Condition(
                                text: "Sunny",
                                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                                code: 1000
                            )
                        ),
                        hour: []
                    )
                ]
            )
        )
    }
} 