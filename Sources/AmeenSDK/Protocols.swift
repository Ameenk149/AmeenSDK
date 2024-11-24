//
//  NetworkManager.swift
//  AmeenSDK
//
//  Created by Muhammad Ameen Khalil Qadri on 23.11.24.
//
import Foundation
import Alamofire

public protocol NetworkManager {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?
    ) async throws -> T
    
    func requestRaw(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: HTTPHeaders?
    ) async throws -> Data
}

public enum NetworkError: Error {
    case invalidURL
    case decodingError
    case serverError(statusCode: Int)
    case unknownError

    public init(afError: AFError) {
        if let statusCode = afError.responseCode {
            self = .serverError(statusCode: statusCode)
        } else {
            self = .unknownError
        }
    }
}

public protocol Middleware {
    func modifyRequest(_ request: URLRequest) -> URLRequest
    func modifyResponse<T: Decodable>(_ response: Result<T, Error>) -> Result<T, Error>
}
