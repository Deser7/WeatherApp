// MARK: - Weather Models
import Foundation

// MARK: - Weather Response
struct WeatherResponse: Codable {
    let forecast: Forecast
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - Forecast Day
struct ForecastDay: Codable, Identifiable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    var id: String { date }
}

// MARK: - Day
struct Day: Codable {
    let maxTempC: Double
    let minTempC: Double
    let avgTempC: Double
    let maxWindKph: Double
    let avgHumidity: Double
    let condition: Condition
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let humidity: Double
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
} 
