// MARK: - Content View
import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = ""
    private let defaultCity = "Moscow"
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    VStack {
                        Text("\(NSLocalizedString("weather.error", comment: "")): \(error.localizedDescription)")
                            .foregroundColor(.red)
                        Button(NSLocalizedString("weather.retry", comment: "")) {
                            viewModel.fetchWeather(for: city.isEmpty ? defaultCity : city)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.forecastDays) { day in
                                WeatherDayView(forecastDay: day)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle(NSLocalizedString("weather.forecast", comment: ""))
            .searchable(text: $city, prompt: NSLocalizedString("weather.search.placeholder", comment: ""))
            .onSubmit(of: .search) {
                if !city.isEmpty {
                    viewModel.fetchWeather(for: city)
                }
            }
            .onAppear {
                viewModel.fetchWeather(for: defaultCity)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
} 

