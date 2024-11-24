//
//  NetworkHelper.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 23.11.24.
//

import Foundation
import Alamofire

public class NetworkHelper {
    private let networkManager: NetworkManager
  
    public init(networkManager: NetworkManager = AlamofireNetworkManager()) {
        self.networkManager = networkManager
   }

    public func fetchData<T: Decodable>(
        from endpoint: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        return try await networkManager.request(
            endpoint: endpoint,
            method: method,
            parameters: parameters,
            headers: headers
        )
    }
    
    public func fetchRawData(
        from endpoint: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: [String: Any]? = nil
    ) async throws -> Data {
        return try await networkManager.requestRaw(
            endpoint: endpoint,
            method: method,
            parameters: parameters,
            headers: headers
        )
    }
    
}
