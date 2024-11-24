//
//  AlamofireNetworkManager.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 23.11.24.
//
import Foundation
import Alamofire

public class AlamofireNetworkManager: NetworkManager {
    
    public init() {}
    
    public func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?
    ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                endpoint,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    
    public func requestRaw(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?
    ) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                endpoint,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
