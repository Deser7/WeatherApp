// MARK: - Weather ViewModel
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
    // MARK: - Properties
    @Published private(set) var forecastDays: [ForecastDay] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let weatherService = WeatherService()
    
    // MARK: - Public Methods
    func fetchWeather(for city: String) {
        isLoading = true
        error = nil
        
        Task {
            do {
                let response = try await weatherService.fetchWeather(for: city)
                forecastDays = response.forecast.forecastday
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
} 