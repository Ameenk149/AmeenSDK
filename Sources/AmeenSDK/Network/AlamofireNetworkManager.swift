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
        // Log request details
        print("\n\n")
        print("------------------------------ REQUEST ---------------------------")
        print("-------------------------------------------------------------------")
        print("🛑 [REQUEST] Endpoint: \(endpoint)")
        print("🛑 [REQUEST] Method: \(method.rawValue)")
        if let parameters = parameters {
            print("🛑 [REQUEST] Parameters: \(prettyPrintedJSON(parameters))")
        } else {
            print("🛑 [REQUEST] Parameters: nil")
        }
        if let headers = headers {
            print("🛑 [REQUEST] Headers: \(headers.dictionary)")
        } else {
            print("🛑 [REQUEST] Headers: nil")
        }
        print("-------------------------------------------------------------------")
        print("\n\n")
     
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
                // Log response details
                print("\n\n")
                print("------------------------------ RESPONSE ---------------------------")
                print("-------------------------------------------------------------------")
                print("🚀 [RESPONSE] Status Code: \(response.response?.statusCode ?? -1)")
                if let data = response.data {
                    print("🚀 [RESPONSE] Data: \(self.prettyPrintedJSON(data))")
                } else {
                    print("🚀 [RESPONSE] Data: nil")
                }
                if let error = response.error {
                    print("❌ [ERROR] \(error.localizedDescription)")
                }
                print("-------------------------------------------------------------------")
                print("\n\n")
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // Helper function to pretty-print JSON
    private func prettyPrintedJSON(_ data: Any) -> String {
        do {
            let jsonData: Data
            if let dictionary = data as? [String: Any] {
                jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            } else if let jsonDataInput = data as? Data {
                jsonData = jsonDataInput
            } else {
                return "\(data)"
            }
            if let prettyString = String(data: jsonData, encoding: .utf8) {
                return prettyString
            }
        } catch {
            return "\(data)"
        }
        return "\(data)"
    }
}
