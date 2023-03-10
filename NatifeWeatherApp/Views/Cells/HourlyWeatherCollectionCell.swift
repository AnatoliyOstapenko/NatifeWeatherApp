//
//  HourlyWeatherCollectionCell.swift
//  NatifeWeatherApp
//
//  Created by AnatoliiOstapenko on 18.02.2023.
//

import UIKit

class HourlyWeatherCollectionCell: UICollectionViewCell {
    
    private let hourLabel = WeatherLabel(fontSize: 18, weight: .medium)
    private let weatherImage = WeatherImageView(frame: .zero)
    private let temperatureLabel = WeatherLabel(fontSize: 20, weight: .medium)
    private let bottomContainer = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        setHourLabel(view: self, label: hourLabel)
        setBottomContainer(view: self, container: bottomContainer, image: weatherImage)
        bottomContainer.addAllSubviews(weatherImage, temperatureLabel)
    }
    
    func updateCollectionCellUI(weather: WeatherData) {
        hourLabel.text = weather.date.hour + Constants.superscriptZero
        temperatureLabel.text = weather.temp
        weatherImage.getIcon(imageString: weather.icon)
    }
}
