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
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertFalse(viewModel.forecastDays.isEmpty)
        XCTAssertNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFailedWeatherFetch() async {
        // Given
        let city = "Moscow"
        mockService.shouldThrowError = true
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertTrue(viewModel.forecastDays.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testLoadingState() async {
        // Given
        let city = "Moscow"
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        XCTAssertTrue(viewModel.isLoading)
        
        // Ждем завершения асинхронной операции
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testEmptyCity() async {
        // Given
        let city = ""
        
        // When
        viewModel.fetchWeather(for: city)
        
        // Then
        // Ждем завершения асинхронной операции
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        XCTAssertTrue(viewModel.forecastDays.isEmpty)
        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.isLoading)
    }
} 