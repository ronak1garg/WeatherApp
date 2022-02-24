//
//  CityListDataModel.swift
//  WeatherIntent
//
//  Created by Ronak Garg on 16/02/22.
//

import Foundation

struct CityListDataModel: Decodable {
    public let cityList: [CityDataModel]
}

struct CityDataModel: Decodable {
    let city: String
    let cityAsciiCode: String
    let latitude: Double
    let longitude: Double
    let id: Int64
    
    enum CodingKeys: String, CodingKey {
        case city
        case cityAsciiCode = "city_ascii"
        case latitude = "lat"
        case longitude = "lng"
        case id
    }
}
