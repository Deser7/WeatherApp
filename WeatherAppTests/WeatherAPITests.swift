import XCTest
@testable import WeatherApp

// MARK: - Weather API Tests
final class WeatherAPITests: XCTestCase {
    // MARK: - Properties
    private var weatherService: WeatherService!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        weatherService = WeatherService()
    }
    
    override func tearDown() {
        weatherService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testFetchWeatherForMoscow() async throws {
        // Given
        let city = "Moscow"
        
        // When
        let response = try await weatherService.fetchWeatherForecast(for: city)
        
        // Then
        XCTAssertFalse(response.forecast.forecastday.isEmpty)
        XCTAssertEqual(response.forecast.forecastday.count, 5)
        
        // Проверяем структуру данных
        let firstDay = response.forecast.forecastday[0]
        XCTAssertNotNil(firstDay.date)
        XCTAssertNotNil(firstDay.day.condition.text)
        XCTAssertNotNil(firstDay.day.condition.icon)
        XCTAssertNotNil(firstDay.day.avgtempC)
        XCTAssertNotNil(firstDay.day.maxwindKph)
        XCTAssertNotNil(firstDay.day.avghumidity)
    }
    
    func testFetchWeatherForInvalidCity() async {
        // Given
        let city = "NonExistentCity123"
        
        // When/Then
        do {
            _ = try await weatherService.fetchWeatherForecast(for: city)
            XCTFail("Expected error for invalid city")
        } catch {
            XCTAssertTrue(error is WeatherError)
        }
    }
    
    func testFetchWeatherForEmptyCity() async {
        // Given
        let city = ""
        
        // When/Then
        do {
            _ = try await weatherService.fetchWeatherForecast(for: city)
            XCTFail("Expected error for empty city")
        } catch {
            XCTAssertTrue(error is WeatherError)
        }
    }
    
    func testWeatherDataConsistency() async throws {
        // Given
        let city = "London"
        
        // When
        let response = try await weatherService.fetchWeatherForecast(for: city)
        
        // Then
        for day in response.forecast.forecastday {
            // Проверяем диапазоны значений
            XCTAssertTrue(day.day.avgtempC >= -50 && day.day.avgtempC <= 50)
            XCTAssertTrue(day.day.maxwindKph >= 0 && day.day.maxwindKph <= 200)
            XCTAssertTrue(day.day.avghumidity >= 0 && day.day.avghumidity <= 100)
            
            // Проверяем наличие иконки
            XCTAssertTrue(day.day.condition.icon.hasPrefix("//cdn.weatherapi.com/weather/"))
            
            // Проверяем формат даты
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            XCTAssertNotNil(dateFormatter.date(from: day.date))
        }
    }
} 
