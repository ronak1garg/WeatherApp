//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Ronak Garg on 16/02/22.
//

import Foundation

let dummyData = WeatherResponseModel(
    dataModel: [WeatherDataModel(temperature: 24.19,
                                 datetime: "24-02-2022",
                                 weather: Weather(icon: "c03d",
                                                  description: "Broken clouds"), countryCode: "IN",
                                 cityName: "Bengaluru")])

struct WeatherResponseModel: Decodable {
    let dataModel: [WeatherDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case dataModel = "data"
    }
    
}

struct WeatherDataModel: Decodable {
    let temperature: Double?
    let datetime: String?
    let weather: Weather?
    let countryCode: String?
    let cityName: String?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case datetime = "datetime"
        case weather = "weather"
        case cityName = "city_name"
        case countryCode = "country_code"
    }
}

struct Weather: Decodable {
    let icon: String?
    let description: String?
}

extension WeatherResponseModel {
    private static let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    var currentTemperature: Double? {
        dataModel?[0].temperature
    }
    
    var iconName: String? {
        dataModel?[0].weather?.icon
    }
    
    var weatherDescription: String? {
        dataModel?[0].weather?.description
    }
    
    var cityName: String? {
        dataModel?[0].cityName
    }
    
    var countryCode: String? {
        dataModel?[0].countryCode
    }
    
    var date: Date {
        if let date = dataModel?[0].datetime?.prefix(10) {
            return Self.dateFormatter.date(from: String(date)) ?? Date()
        } else {
            return Date()
        }
    }
}

