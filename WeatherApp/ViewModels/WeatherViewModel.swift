import Foundation

// MARK: - Weather View Model
@MainActor
final class WeatherViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var forecastDays: [ForecastDay] = []
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - Private Properties
    private let weatherService: WeatherServiceProtocol
    
    // MARK: - Initialization
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func fetchWeather(for city: String) {
        Task {
            await fetchWeatherData(for: city)
        }
    }
    
    // MARK: - Private Methods
    private func fetchWeatherData(for city: String) async {
        isLoading = true
        error = nil
        
        do {
            let response = try await weatherService.fetchWeatherForecast(for: city)
            forecastDays = response.forecast.forecastday
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
} 
