//
//  Untitled.swift
//  CodeTeamTestTask
//
//  Created by Mike Panchenko on 15.08.2025.
//
import Combine
import Foundation
/// Networking Service that make one post request encode model and create base64encoded string returning AnyPublisher<Never, NetworkError>
protocol NetworkService {
    func sendBatteryLevel(model: DeviceInfoModel) -> AnyPublisher<Never, NetworkError>
}

enum NetworkError: Error {
    case encodeError
    case wrongURL
    case networkError(Int)
}

class INetworkService: NetworkService {
    
    func sendBatteryLevel(model: DeviceInfoModel) -> AnyPublisher<Never, NetworkError> {
        guard let jsonData = try? JSONEncoder().encode(model),
              let jsonDataString = jsonData.base64EncodedString().data(using: .utf8) else {
            return Fail(error: NetworkError.encodeError).eraseToAnyPublisher()
        }
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/post") else {
            return Fail(error: NetworkError.wrongURL).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonDataString
        return URLSession.shared.dataTaskPublisher(for: request)
            .ignoreOutput()
            .mapError { failure in
                return NetworkError.networkError(failure.errorCode)
            }
            .eraseToAnyPublisher()
        
    }
}
