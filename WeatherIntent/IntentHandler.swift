//
//  IntentHandler.swift
//  WeatherIntent
//
//  Created by Ronak Garg on 15/02/22.
//

import Intents

final class IntentHandler: INExtension, WeatherIntentHandling {
    
    func provideCityNamesOptionsCollection(for intent: WeatherIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<CityData>?, Error?) -> Void) {
        if let dataModel = try? getCityListResponse(
            fromAsset: "cities.json",
            responseModel: CityListDataModel.self),
           let searchTerm = searchTerm {
            
            let data: [CityData] = dataModel
                .cityList.compactMap { model -> CityData? in
                    if model.cityAsciiCode.contains(searchTerm) {
                        let data = CityData(identifier: model.cityAsciiCode,
                                            display: model.city)
                        
                        data.latitude = NSNumber(value: model.latitude)
                        data.longitude = NSNumber(value: model.longitude)
                        return data
                    } else {
                        return nil
                    }
                }
            let collection = INObjectCollection(items: data)
            completion(collection, nil)
        } else {
            completion(nil, nil)
        }
    }
    
    func getCityListResponse<T: Decodable>(
        fromAsset asset: String,
        responseModel _: T.Type
    ) throws -> CityListDataModel {
        let responseJsonData = StorageHelper()
            .getData(assetName: asset)
        let decodeModel = CityListDataModel.self
        let decoder = JSONDecoder()
        
        return try require(decoder.decode(decodeModel, from: responseJsonData))
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
}
