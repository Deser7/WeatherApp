import SwiftUI

// MARK: - Weather Day Cell
struct WeatherDayCell: View {
    // MARK: - Properties
    let forecastDay: ForecastDay
    @State private var weatherImage: UIImage?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(forecastDay.date.formattedDate)
                .font(.headline)
            
            HStack {
                if let image = weatherImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
                
                VStack(alignment: .leading) {
                    Text(forecastDay.day.condition.text)
                        .font(.subheadline)
                    
                    Text("Temperature: \(Int(forecastDay.day.avgtempC))°C")
                        .font(.subheadline)
                }
            }
            
            HStack {
                WeatherInfoView(
                    icon: "wind",
                    value: String(format: "%.1f m/s", forecastDay.day.maxwindKph.kilometersPerHourToMetersPerSecond),
                    title: "Wind"
                )
                
                Spacer()
                
                WeatherInfoView(
                    icon: "humidity",
                    value: "\(Int(forecastDay.day.avghumidity))%",
                    title: "Humidity"
                )
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
        .task {
            await loadWeatherImage()
        }
    }
    
    // MARK: - Private Methods
    private func loadWeatherImage() async {
        guard let url = URL(string: "https:\(forecastDay.day.condition.icon)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    weatherImage = image
                }
            }
        } catch {
            print("Error loading image.")
        }
    }
}

// MARK: - Weather Info View
private struct WeatherInfoView: View {
    let icon: String
    let value: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title2)
            Text(value)
                .font(.caption)
            Text(title)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
#Preview {
    WeatherDayCell(forecastDay: ForecastDay(
        date: "2025-06-01",
        day: Day(
            maxtempC: 20,
            mintempC: 10,
            avgtempC: 15,
            maxwindKph: 15,
            avghumidity: 60,
            condition: Condition(
                text: "Sunny",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                code: 1000
            )
        ),
        hour: []
    ))
    .padding()
} 
