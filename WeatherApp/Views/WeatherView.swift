import SwiftUI

// MARK: - Weather View
struct WeatherView: View {
    // MARK: - Properties
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = "Moscow"
    
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
                        Text(error)
                            .foregroundColor(.red)
                        Button("Repeat") {
                            viewModel.fetchWeather(for: city)
                        }
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.forecastDays, id: \.date) { day in
                                WeatherDayCell(forecastDay: day)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Weather")
            .searchable(text: $city, prompt: "Enter your city")
            .onSubmit(of: .search) {
                viewModel.fetchWeather(for: city)
            }
            .onAppear {
                viewModel.fetchWeather(for: city)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    WeatherView()
} 
