import Foundation
import CoreLocation

struct OpenWeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]

    struct Main: Decodable {
        let temp: Double
    }

    struct Weather: Decodable {
        let main: String // Napr. "Clear", "Clouds", "Rain"
        let icon: String
        let description: String
    }
}

class OpenWeatherService: ObservableObject {
    @Published var temperature: String = "--°"
    @Published var condition: String = "Clear"
    @Published var iconID: String = ""

    private let apiKey = "80c332c5ad90f9a7134924e58ce2d92e" 

    func fetchWeather(for location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.temperature = "\(Int(decoded.main.temp))°"
                    self.condition = decoded.weather.first?.main ?? "Clear" // Stav počasia, ktorý použijeme na zmenu ikonky
                    self.iconID = decoded.weather.first?.icon ?? ""
                }
            } catch {
                print("❌ Error decoding weather: \(error)")
            }
        }.resume()
    }
}
