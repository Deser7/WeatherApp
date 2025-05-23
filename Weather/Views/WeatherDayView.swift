// MARK: - Weather Day View
import SwiftUI

struct WeatherDayView: View {
    // MARK: - Properties
    let forecastDay: ForecastDay
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(forecastDay.date.toFormattedDate())
                .font(.headline)
            
            HStack {
                AsyncImage(url: URL(string: "https:\(forecastDay.day.condition.icon)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                
                VStack(alignment: .leading) {
                    Text(forecastDay.day.condition.text.localizedWeatherCondition())
                        .font(.subheadline)
                    
                    Text("weather.units.temperature".localizedFormat(Int(forecastDay.day.avgTempC)))
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Label(
                        "weather.units.wind".localizedFormat(
                            Int(forecastDay.day.maxWindKph.kilometersPerHourToMetersPerSecond())
                        ),
                        systemImage: "wind"
                    )
                    Label(
                        "weather.units.humidity".localizedFormat(Int(forecastDay.day.avgHumidity)),
                        systemImage: "humidity"
                    )
                }
                .font(.caption)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

// MARK: - Preview
#Preview {
    WeatherDayView(forecastDay: ForecastDay(
        date: "2024-03-20",
        day: Day(
            maxTempC: 15.0,
            minTempC: 5.0,
            avgTempC: 10.0,
            maxWindKph: 20.0,
            avgHumidity: 65.0,
            condition: Condition(
                text: "partly_cloudy",
                icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
                code: 1000
            )
        ),
        hour: []
    ))
    .padding()
} 
