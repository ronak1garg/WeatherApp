//
//  StorageHelper.swift
//  WeatherIntent
//
//  Created by Ronak Garg on 16/02/22.
//

import Foundation

final class StorageHelper {
    func getData(assetName: String) -> Data {
        let bundle = Bundle(for: StorageHelper.self)
        let url = bundle.url(forResource: assetName,
                             withExtension: nil)
        return try! Data(contentsOf: url!)
    }
}

struct RequiredError<T>: LocalizedError {
    let line: UInt
    let file: StaticString

    var errorDescription: String? {
        return "😱 Required value of type \(T.self) was nil at line \(line) in file \(file)."
    }
}

func require<T>(_ object: T?,
                line: UInt = #line,
                file: StaticString = #file) throws -> T {
    guard let obj = object else {
        throw RequiredError<T>(line: line,
                               file: file)
    }

    return obj
}
