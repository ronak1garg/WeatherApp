//
//  Provider.swift
//  WeatherWidgetExtension
//
//  Created by Ronak Garg on 16/02/22.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    let apiService = WeatherAPIService()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    weatherModel: dummyData,
                    units: .celcius,
                    theme: .light)
    }
    
    func getSnapshot(for configuration: WeatherIntent,
                     in context: Context,
                     completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                weatherModel: dummyData,
                                units: .celcius,
                                theme: .light)
        completion(entry)
    }
    
    func getTimeline(for configuration: WeatherIntent,
                     in context: Context,
                     completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        
        let nextUpdateDate = Calendar.current.date(byAdding: .hour,
                                                   value: 1,
                                                   to: Date())!
        
        let model = configuration.cityNames
        apiService.weatherDataForLocation(
            latitude: model?.latitude?.doubleValue ?? 12.97,
            longitude: model?.longitude?.doubleValue ?? 77.59,
            units: getUnit(from: configuration)) { response,
                                                   error in
            if error == nil,
               let dataModel = response {
                let entry = SimpleEntry(date: Date(),
                                        weatherModel: dataModel,
                                        units: configuration.unit,
                                        theme: getTheme(from: configuration))
                
                let timeline = Timeline(entries: [entry],
                                        policy: .after(nextUpdateDate))
                completion(timeline)
            } else {
                
            }
        }
    }
    
    func getUnit(from intent: WeatherIntent) -> String {
        switch intent.unit {
        case .celcius, .unknown:
            return "M"
        case .fahrenheit:
            return "I"
        }
    }
    
    func getTheme(from intent: WeatherIntent) -> ColorScheme {
        switch intent.switchTheme {
        case .light, .unknown:
            return .light
        case .dark:
            return .dark
        }
    }
    
}
