//
//  Forecast.swift
//  Wheather App with Xib
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 14/12/22.
//

import Foundation

struct WeatherInfo {
    let temp: Float
    let min_temp: Float
    let max_temp: Float
    let description: String
    let icon: String
    let time: String
}

struct ForecastTemperature {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
}
