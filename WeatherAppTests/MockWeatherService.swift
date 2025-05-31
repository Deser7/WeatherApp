import Foundation
@testable import WeatherApp

// MARK: - Mock Weather Service
final class MockWeatherService: WeatherServiceProtocol {
    // MARK: - Properties
    var shouldThrowError = false
    var mockResponse: WeatherResponse?
    var delay: TimeInterval = 0.5
    
    // MARK: - Public Methods
    func fetchWeatherForecast(for city: String) async throws -> WeatherResponse {
        // Имитируем задержку сетевого запроса
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5 секунды
        
        if shouldThrowError {
            throw WeatherError.invalidCity
        }
        
        if let mockResponse = mockResponse {
            return mockResponse
        }
        
        // Возвращаем тестовые данные
        return WeatherResponse(
            location: Location(
                name: city,
                region: "Test Region",
                country: "Test Country",
                lat: 0.0,
                lon: 0.0,
                localtime: "2024-03-20 12:00"
            ),
            current: Current(
                tempC: 20.0,
                condition: Condition(
                    text: "Sunny",
                    icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                    code: 1000
                ),
                windKph: 10.0,
                humidity: 50,
                feelslikeC: 22.0
            ),
            forecast: Forecast(
                forecastday: [
                    ForecastDay(
                        date: "2024-03-20",
                        day: Day(
                            maxtempC: 25.0,
                            mintempC: 15.0,
                            avgtempC: 20.0,
                            maxwindKph: 21.0,
                            avghumidity: 5,
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
