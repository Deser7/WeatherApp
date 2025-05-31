import Foundation
import Combine

// MARK: - Weather View Model
final class WeatherViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var forecastDays: [ForecastDay] = []
    @Published var isLoading = false
    @Published var error: String?
    
    // MARK: - Private Properties
    private let weatherService: WeatherServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func fetchWeather(for city: String) {
        isLoading = true
        error = nil
        
        weatherService.fetchWeatherForecast(for: city)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.forecastDays = response.forecast.forecastday
            }
            .store(in: &cancellables)
    }
} 
