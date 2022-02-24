//
//  WeatherAPIService.swift
//  WeatherApp
//
//  Created by Ronak Garg on 16/02/22.
//

import Foundation

final class WeatherAPIService {
    typealias WeatherDataCompletion = (WeatherResponseModel?,
                                       WeatherAPIError?) -> ()
    private let urlSession: URLSession
    private let concurrentQueue = DispatchQueue(
        label: "com.weatherApp.WeatherAPIService",
        qos: .userInitiated,
        attributes: .concurrent)
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func weatherDataForLocation(latitude: Double,
                                longitude: Double,
                                units: String = "M",
                                completion: @escaping WeatherDataCompletion) {
        let requestParams = requestParameters(latitude: latitude,
                                              longitude: longitude,
                                              units: units)
        if let url = createUrl(from: requestParams) {
            let request = URLRequest(url: url)
            let task = urlSession
                .dataTask(with: request) { [weak self] (data, response, error) in
                    self?.concurrentQueue.async {
                        guard error == nil else {
                            completion(nil, .failedRequest)
                            return
                        }
                        
                        guard let data = data else {
                            completion(nil, .noData)
                            return
                        }
                        
                        guard let response = response as? HTTPURLResponse else {
                            completion(nil, .invalidResponse)
                            return
                        }
                        
                        guard response.statusCode == 200 else {
                            completion(nil, .failedRequest)
                            return
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            let weatherData: WeatherResponseModel = try decoder.decode(WeatherResponseModel.self, from: data)
                            completion(weatherData, nil)
                        } catch {
                            completion(nil, .invalidData)
                        }
                    }
                }
            task.resume()
        }
    }

}

private extension WeatherAPIService {
    func createUrl(from parameters: [String: String]) -> URL? {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = "api.weatherbit.io"
        urlBuilder.path = "/v2.0/current"
        urlBuilder.queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return urlBuilder.url
    }
    
    func requestParameters(latitude: Double,
                           longitude: Double,
                           units: String = "M",
                           key: String = "Custom API Key")
    -> [String: String] {
        var dict: [String: String] = [:]
        dict["key"] = key
        dict["units"] = units.capitalized
        dict["lat"] = "\(latitude)"
        dict["lon"] = "\(longitude)"
        return dict
    }
}
enum WeatherAPIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}
