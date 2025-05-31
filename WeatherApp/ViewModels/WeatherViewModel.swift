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
    private var currentTask: Task<Void, Never>?
    
    // MARK: - Initialization
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func fetchWeather(for city: String) {
        // Отменяем предыдущую задачу, если она есть
        currentTask?.cancel()
        
        // Сбрасываем состояние
        forecastDays = []
        error = nil
        isLoading = true
        
        // Проверяем, что город не пустой
        guard !city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            error = "Название города не может быть пустым"
            isLoading = false
            return
        }
        
        // Создаем новую задачу
        currentTask = Task { [weak self] in
            guard let self = self else { return }
            
            // Проверяем, не была ли задача отменена
            guard !Task.isCancelled else { return }
            
            await self.fetchWeatherData(for: city)
        }
    }
    
    // MARK: - Private Methods
    private func fetchWeatherData(for city: String) async {
        // Проверяем, не была ли задача отменена
        guard !Task.isCancelled else { return }
        
        do {
            let response = try await weatherService.fetchWeatherForecast(for: city)
            
            // Проверяем, не была ли задача отменена
            guard !Task.isCancelled else { return }
            
            forecastDays = response.forecast.forecastday
            error = nil
        } catch {
            // Проверяем, не была ли задача отменена
            guard !Task.isCancelled else { return }
            
            self.error = error.localizedDescription
            forecastDays = []
        }
        
        isLoading = false
    }
} 
