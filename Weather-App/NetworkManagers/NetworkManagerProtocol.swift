//
//  NetworkManagerProtocol.swift
//  Wheather App with Xib
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 09/12/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(city: String, completion: @escaping (WeatherModel) -> ())
    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}
