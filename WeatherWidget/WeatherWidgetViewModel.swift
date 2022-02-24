//
//  WeatherWidgetViewModel.swift
//  WeatherWidgetExtension
//
//  Created by Ronak Garg on 16/02/22.
//

import Foundation
import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weatherModel: WeatherResponseModel
    let units: Unit
    let theme: ColorScheme
}

struct WeatherWidgetViewModel {
    let date: String
    let iconName: String
    let countryCode: String
    let cityName: String
    let weatherDescription: String
    let currentTemperatureString: String
    let theme: ColorScheme
    
    private let tempFormatter: NumberFormatter = {
        let tempFormatter = NumberFormatter()
        tempFormatter.numberStyle = .none
        return tempFormatter
    }()
    
    private let dateFormatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "EEEE, MMM d"
      return dateFormatter
    }()
    
    init(entry: SimpleEntry) {
        date = dateFormatter.string(from: entry.date)
        iconName = entry.weatherModel.iconName ?? ""
        cityName = entry.weatherModel.cityName ?? ""
        countryCode = entry.weatherModel.countryCode ?? ""
        weatherDescription = entry.weatherModel.weatherDescription ?? ""
        let temp = tempFormatter.string(from: (entry.weatherModel.currentTemperature ?? 0) as NSNumber) ?? ""
        currentTemperatureString = temp
            .appending("°\(entry.units == .celcius ? "C" : "F")")
        self.theme = entry.theme
    }
}

