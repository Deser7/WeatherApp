import Foundation

// MARK: - Weather Response
struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let humidity: Int
    let feelslikeC: Double
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - Forecast Day
struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

// MARK: - Day
struct Day: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let maxwindKph: Double
    let avghumidity: Int
    let condition: Condition
}

// MARK: - Hour
struct Hour: Codable {
    let time: String
    let tempC: Double
    let condition: Condition
    let windKph: Double
    let humidity: Int
    let feelslikeC: Double
} 