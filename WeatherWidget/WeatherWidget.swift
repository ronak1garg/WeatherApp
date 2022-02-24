//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Ronak Garg on 15/02/22.
//

import WidgetKit
import SwiftUI
import Intents

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidgetIdentifier"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: WeatherIntent.self,
                            provider: Provider()) { entry in
            return WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Weather Widget")
        .description("This widget will show weather of the city you are selecting.")
        .supportedFamilies([.systemSmall])
    }
}
