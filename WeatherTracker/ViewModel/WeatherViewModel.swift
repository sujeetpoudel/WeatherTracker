//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Sujeet Poudel on 2/2/25.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var city: String = "" {
        didSet {
            fetchWeather(for: city)
        }
    }
    
    init() {
        restoreSavedCityIfPresent()
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "b803b421ecc64190b70164359250202"
    
    func fetchWeather(for city: String) {
        guard !city.isEmpty else {
            self.city = UserDefaults.standard.string(forKey: "savedCity") ?? ""
            return
        }
        
        let urlString = "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] response in
                self?.weather = response
                print(response)
            })
            .store(in: &cancellables)
    }
    
    func saveCity(city: String) {
        UserDefaults.standard.setValue(city, forKey: "savedCity")
    }
    
    func restoreSavedCityIfPresent() {
        if let city = UserDefaults.standard.string(forKey: "savedCity") {
            self.city = city
        }
    }
}
