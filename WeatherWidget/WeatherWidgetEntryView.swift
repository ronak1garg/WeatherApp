//
//  WeatherWidgetEntryView.swift
//  WeatherWidgetExtension
//
//  Created by Ronak Garg on 16/02/22.
//

import SwiftUI
import WidgetKit

struct WeatherWidgetEntryView : View {
    let viewModel: WeatherWidgetViewModel
    init(entry: SimpleEntry) {
        self.viewModel = WeatherWidgetViewModel(entry: entry)
    }
    var colors: [Color] {
        return viewModel.theme == .light ? [Color(.systemBlue), Color(.systemBackground)] : [Color(.systemGreen), Color(.systemRed)]
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 10) {
                VStack(alignment: .leading) {
                    HStack(spacing: 0) {
                        Text(viewModel.cityName)
                            .fontWeight(.bold)
                        Text(", ")
                            .fontWeight(.bold)
                        Text(viewModel.countryCode)
                            .fontWeight(.bold)
                    }.font(.system(size: 14))
                    Text(viewModel.currentTemperatureString)
                        .fontWeight(.semibold)
                        .font(.system(size: 22))
                }
                Image(viewModel.iconName)
                    .frame(width: 30, height: 30)
                VStack(alignment: .center, spacing: 4) {
                    Text(viewModel.weatherDescription)
                        .fontWeight(.semibold)
                        .font(.system(size: 11))
                    
                    Text(viewModel.date)
                        .fontWeight(.semibold)
                        .font(.system(size: 10))
                }
            }
        }
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        return Group {
            WeatherWidgetEntryView(entry: SimpleEntry(date: Date(),
                                                      weatherModel: dummyData, units: .celcius,
                                                      theme: .light))
                .environment(\.colorScheme, .dark)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            WeatherWidgetEntryView(entry: SimpleEntry(date: Date(),
                                                      weatherModel: dummyData, units: .celcius,
                                                      theme: .light))
                .environment(\.colorScheme, .light)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
