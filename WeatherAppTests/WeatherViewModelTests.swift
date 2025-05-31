import XCTest
@testable import WeatherApp

// MARK: - Weather View Model Tests
@MainActor
final class WeatherViewModelTests: XCTestCase {
    // MARK: - Properties
    private var viewModel: WeatherViewModel!
    private var mockService: MockWeatherService!
    
    // MARK: - Setup
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testSuccessfulWeatherFetch() async {
        // Given
        let city = "Moscow"
        let expectation = expectation(description: "Weather fetch completed")
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        // Проверяем конечное состояние
        XCTAssertFalse(viewModel.forecastDays.isEmpty, "Forecast days should not be empty")
        XCTAssertNil(viewModel.error, "Error should be nil")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false")
    }
    
    func testFailedWeatherFetch() async {
        // Given
        let city = "Moscow"
        mockService.shouldThrowError = true
        let expectation = expectation(description: "Weather fetch failed")
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        // Проверяем конечное состояние
        XCTAssertTrue(viewModel.forecastDays.isEmpty, "Forecast days should be empty")
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false")
    }
    
    func testLoadingState() async {
        // Given
        let city = "Moscow"
        let expectation = expectation(description: "Loading state changed")
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        // Проверяем конечное состояние
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after completion")
    }
    
    func testEmptyCity() async {
        // Given
        let city = ""
        let expectation = expectation(description: "Empty city handled")
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        // Проверяем конечное состояние
        XCTAssertTrue(viewModel.forecastDays.isEmpty, "Forecast days should be empty")
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false")
    }
} 