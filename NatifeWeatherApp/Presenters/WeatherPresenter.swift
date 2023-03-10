//
//  WeatherPresenter.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 11.02.2023.
//

import UIKit

protocol WeatherViewProtocol: AnyObject {
    func setWeather(weather: [WeatherData], filteredWeather: [WeatherData], city: String)
}

protocol WeatherPresenterProtocol: AnyObject {
    init (view: WeatherViewProtocol, networkManager: NetworkManagerProtocol)
    func getWeatherByLocation(lat: Double, lon: Double)
}

class WeatherPresenter: WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol?
    private let networkManager: NetworkManagerProtocol
    
    private var weather: [WeatherData] = []
    private var filteredWeather: [WeatherData] = []
    
    required init(view: WeatherViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func getWeatherByLocation(lat: Double, lon: Double) {
        networkManager.weatherByLocation(lat: lat, lon: lon) { [weak self] weather in
            guard let self = self else { return }
            self.handleWeatherResult(weather)
        }
    }
    
    private func handleWeatherResult(_ result: Result<WeatherModel, NetworkErrors>) {
        /// clear arrays before new fetching weather data
        self.weather.removeAll()
        self.filteredWeather.removeAll()
        
        DispatchQueue.main.async {
            switch result {
            case .success(let weather):
                weather.list.forEach {
                    let weatherData = WeatherData(date: $0.date,
                                                  temp: $0.main.temp.temperatured,
                                                  icon: $0.weather.first?.icon ?? "",
                                                  humidity: String($0.main.humidity),
                                                  tempMin: $0.main.tempMin.temperatured,
                                                  tempMax: $0.main.tempMax.temperatured,
                                                  speed: $0.wind.speed.roundSpeed,
                                                  deg: $0.wind.deg.directionToSymbol(Double($0.wind.deg)))
                    /// add all data from weather API
                    self.weather.append(weatherData)
                    /// add filtered data day by day for Forecast VC
                    if !self.filteredWeather.contains(where: { $0.date.dayOfWeek == weatherData.date.dayOfWeek }) {
                        self.filteredWeather.append(weatherData)
                    }
                }
                /// prefix to filter the first 9 elements from the array. delete if you want
                self.view?.setWeather(weather: Array(self.weather.prefix(9)),
                                      filteredWeather: self.filteredWeather, city: weather.city.name)
                
            case .failure(let error):
                print("Error with fetchimg data in Presenter \(error)")
            }
        }
    }
}


