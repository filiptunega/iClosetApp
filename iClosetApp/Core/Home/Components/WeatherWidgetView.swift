import SwiftUI
import CoreLocation

struct WeatherWidgetView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var weatherService = OpenWeatherService()

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                // Dynamické používanie systemName ikonky s farebným podkladom
                Image(systemName: weatherIcon(for: weatherService.condition))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(iconColor(for: weatherService.condition)) // Dynamická farba

                VStack(alignment: .leading, spacing: 2) {
                    Text("\(weatherService.temperature) \(weatherService.condition)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("TextPrimary"))

                    Text("Today")
                        .font(.caption2)
                        .foregroundColor(Color("TextSecondary"))
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 70, alignment: .leading)
        .background(Color("WidgetPrimary"))
        .cornerRadius(12)
        .shadow(color: Color("Shadow").opacity(0.05), radius: 4, x: 0, y: 2)
        .onAppear {
            tryFetchWeather()
        }
    }

    private func tryFetchWeather() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let location = locationManager.location {
                weatherService.fetchWeather(for: location)
            } else {
                tryFetchWeather()
            }
        }
    }

    // Priradenie správnej ikony pre rôzne podmienky
    private func weatherIcon(for condition: String) -> String {
        switch condition.lowercased() {
        case "clear":
            return "sun.max.fill"
        case "clouds":
            return "cloud.fill"
        case "rain":
            return "cloud.rain.fill"
        case "snow":
            return "cloud.snow.fill"
        case "fog":
            return "cloud.fog.fill"
        case "storm":
            return "cloud.bolt.rain.fill"
        default:
            return "questionmark.circle" // Predvolená ikona
        }
    }

    // Dynamické priradenie farby ikonky podľa stavu počasia
    private func iconColor(for condition: String) -> Color {
        switch condition.lowercased() {
        case "clear":
            return .yellow // Slnečné počasie (žltá)
        case "clouds":
            return Color("TextPrimary") // Oblačno (biela)
        case "rain":
            return .blue // Dážď (modrá)
        case "snow":
            return Color("TextPrimary") // Sneženie (biela)
        case "fog":
            return .gray // Hmla (šedá)
        case "storm":
            return .blue // Búrka (modrá)
        default:
            return .gray // Predvolená farba
        }
    }
}
