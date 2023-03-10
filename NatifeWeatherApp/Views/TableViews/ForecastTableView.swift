//
//  ForecastTableView.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class ForecastTableView: UITableView {
    
    private var weather: [WeatherData] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateForecastTV(weather: [WeatherData]) {
        self.weather = weather
    }
    
    private func configureUI() {
        backgroundColor = .clear
        register(ForecastTableViewCell.self, forCellReuseIdentifier: String(describing: ForecastTableViewCell.self))
        dataSource = self
        delegate = self
        separatorStyle = .none
    }
}

extension ForecastTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastTableViewCell.self), for: indexPath) as! ForecastTableViewCell
        cell.updateForecastCell(weather: weather[indexPath.row],
                                icon: weather[indexPath.row].icon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
