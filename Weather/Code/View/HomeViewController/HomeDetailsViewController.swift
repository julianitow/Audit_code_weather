//
//  HomeDetailsViewController.swift
//  Weather
//
//  Created by Toto on 31/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    
    /* I chose to do this view programmatically unlike the HomeViewController. Just for fun ☺️. */
    
    //MARK: Property
    var weather: WeatherProtocol?
    var backgroundColor: UIColor?
    
    //MARK: Views
    fileprivate let scrollView: UIScrollView = UIScrollView()
    fileprivate let mainStackView: UIStackView = UIStackView()
    fileprivate let dateLabel: UILabel = UILabel()
    fileprivate let weatherImageView: UIImageView = UIImageView()
    fileprivate let temperatureLabel: UILabel = UILabel()
    fileprivate let humidityStackView: UIStackView = UIStackView()
    fileprivate let humidity: UILabel = UILabel()
    fileprivate let humidityValueLabel: UILabel = UILabel()
    fileprivate let pressureStackView: UIStackView = UIStackView()
    fileprivate let pressureLabel: UILabel = UILabel()
    fileprivate let pressureValueLabel: UILabel = UILabel()
    fileprivate let rainStackView: UIStackView = UIStackView()
    fileprivate let rainLabel: UILabel = UILabel()
    fileprivate let rainValueLabel: UILabel = UILabel()
    fileprivate let windStackView: UIStackView = UIStackView()
    fileprivate let windLabel: UILabel = UILabel()
    fileprivate let windValueLabel: UILabel = UILabel()
    
    //MARK: Life Cycle
    override func loadView() {
        super.loadView()
        
        self.navigationController?.navigationBar.tintColor = backgroundColor
        self.view.backgroundColor = backgroundColor
        
        self.setupViewsAndConstraints()
        self.configureSubviewsWith(self.weather)
    }
    
    //MARK: Configure Subviews
    /* Configure subviews with properties since forecasts. */
    func configureSubviewsWith(_ weather: WeatherProtocol?) {
        guard let weather = weather else { return }
        
        self.dateLabel.text = WeatherUtils.changeDateFormat(dateString: weather.date)
        if let temperature = weather.temperature {
            self.temperatureLabel.text = String(format: "%.0f", temperature - 273.15) + "°C"
        } else {
            self.temperatureLabel.text = "0°C"
        }
        self.humidityValueLabel.text = "\(weather.humidity ?? 0) %"
        self.pressureValueLabel.text = "\(weather.pressure ?? 0)Pa"
        self.rainValueLabel.text = "\(weather.rain ?? 0) mm/3h"
        self.windValueLabel.text = "\(weather.wind ?? 0)km/h"
    }
    
    //MARK: Setup Views and Constraints
    private func setupViewsAndConstraints() {
        self.setupScrollView()
        self.setupMainStackView()
        self.setupDateLabel()
        self.setupWeatherImageView()
        self.setupTemperatureLabel()
        self.setupHumidityStackView()
        self.setupHumidityLabel()
        self.setupHumidityValueLabel()
        self.setupPressureStackView()
        self.setupPressureLabel()
        self.setupPressureValueLabel()
        self.setupRainStackView()
        self.setupRainLabel()
        self.setupRainValueLabel()
        self.setupWindStackView()
        self.setupWindLabel()
        self.setupWindValueLabel()
        self.setupScrollViewConstraints()
        self.setupMainStackViewConstraints()
    }
    
    //MARK: Setup Views
    private func setupScrollView() {
        self.view.addSubview(self.scrollView)
    }
    
    private func setupMainStackView() {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fillProportionally
        self.mainStackView.spacing = 20
        self.scrollView.addSubview(self.mainStackView)
    }
    
    private func setupDateLabel() {
        self.dateLabel.textColor = UIColor.white
        self.dateLabel.textAlignment = .center
        self.dateLabel.font = UIFont.systemFont(ofSize: 30)
        self.mainStackView.addArrangedSubview(self.dateLabel)
    }
    
    private func setupWeatherImageView() {
        self.weatherImageView.contentMode = .scaleAspectFit
        self.mainStackView.addArrangedSubview(self.weatherImageView)
    }
    
    private func setupTemperatureLabel() {
        self.temperatureLabel.textColor = UIColor.white
        self.temperatureLabel.textAlignment = .center
        self.temperatureLabel.font = UIFont.systemFont(ofSize: 100)
        self.mainStackView.addArrangedSubview(self.temperatureLabel)
    }
    
    private func setupHumidityStackView() {
        self.humidityStackView.axis = .horizontal
        self.humidityStackView.alignment = .fill
        self.humidityStackView.distribution = .fillProportionally
        self.mainStackView.addArrangedSubview(self.humidityStackView)
    }
    
    private func setupHumidityLabel() {
        self.humidity.text = "Humidité"
        self.humidity.textColor = UIColor.white
        self.humidity.textAlignment = .left
        self.humidity.font = UIFont.systemFont(ofSize: 30)
        self.humidityStackView.addArrangedSubview(self.humidity)
    }
    
    private func setupHumidityValueLabel() {
        self.humidityValueLabel.textColor = UIColor.white
        self.humidityValueLabel.textAlignment = .right
        self.humidityValueLabel.font = UIFont.systemFont(ofSize: 30)
        self.humidityStackView.addArrangedSubview(self.humidityValueLabel)
    }
    
    private func setupPressureStackView() {
        self.pressureStackView.axis = .horizontal
        self.pressureStackView.alignment = .fill
        self.pressureStackView.distribution = .fillProportionally
        self.mainStackView.addArrangedSubview(self.pressureStackView)
    }
    
    private func setupPressureLabel() {
        self.pressureLabel.text = "Pression"
        self.pressureLabel.textColor = UIColor.white
        self.pressureLabel.textAlignment = .left
        self.pressureLabel.font = UIFont.systemFont(ofSize: 30)
        self.pressureStackView.addArrangedSubview(self.pressureLabel)
    }
    
    private func setupPressureValueLabel() {
        self.pressureValueLabel.textColor = UIColor.white
        self.pressureValueLabel.textAlignment = .right
        self.pressureValueLabel.font = UIFont.systemFont(ofSize: 30)
        self.pressureStackView.addArrangedSubview(self.pressureValueLabel)
    }
    
    private func setupRainStackView() {
        self.rainStackView.axis = .horizontal
        self.rainStackView.alignment = .fill
        self.rainStackView.distribution = .fillProportionally
        self.mainStackView.addArrangedSubview(self.rainStackView)
    }
    
    private func setupRainLabel() {
        self.rainLabel.text = "Vent"
        self.rainLabel.textColor = UIColor.white
        self.rainLabel.textAlignment = .left
        self.rainLabel.font = UIFont.systemFont(ofSize: 30)
        self.rainStackView.addArrangedSubview(self.rainLabel)
    }
    
    private func setupRainValueLabel() {
        self.rainValueLabel.textColor = UIColor.white
        self.rainValueLabel.textAlignment = .right
        self.rainValueLabel.font = UIFont.systemFont(ofSize: 30)
        self.rainStackView.addArrangedSubview(self.rainValueLabel)
    }
    
    private func setupWindStackView() {
        self.windStackView.axis = .horizontal
        self.windStackView.alignment = .fill
        self.windStackView.distribution = .fillProportionally
        self.mainStackView.addArrangedSubview(self.windStackView)
    }
    
    private func setupWindLabel() {
        self.windLabel.text = "Vent"
        self.windLabel.textColor = UIColor.white
        self.windLabel.textAlignment = .left
        self.windLabel.font = UIFont.systemFont(ofSize: 30)
        self.windStackView.addArrangedSubview(self.windLabel)
    }
    
    private func setupWindValueLabel() {
        self.windValueLabel.textColor = UIColor.white
        self.windValueLabel.textAlignment = .right
        self.windValueLabel.font = UIFont.systemFont(ofSize: 30)
        self.windStackView.addArrangedSubview(self.windValueLabel)
    }
    
    
    //MARK: Setup Views Constraints
    fileprivate func setupScrollViewConstraints() {
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15)
            ])
    }
    
    private func setupMainStackViewConstraints() {
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mainStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 40),
            self.mainStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.mainStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.mainStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.mainStackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor)
            ])
    }
}

