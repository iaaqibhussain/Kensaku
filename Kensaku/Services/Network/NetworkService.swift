//
//  NetworkService.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

protocol NetworkService {
    func execute<T: Decodable>(_ request: NetworkServiceRequest) async throws -> T
}

final class NetworkServiceImpl: NetworkService {
    private let urlSession: URLSession
    private let parser: JsonParser
    
    init(
        urlSession: URLSession = URLSession.shared,
        parser: JsonParser = JsonParserImpl()
    ) {
        self.urlSession = urlSession
        self.parser = parser
    }
    
    func execute<T: Decodable>(_ request: NetworkServiceRequest) async throws -> T {
        do {
            let urlRequest = try request.createURLRequest()
            
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkRequestError.invalidResponse
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkRequestError.statusCode(httpResponse.statusCode)
            }
            
            do {
                return try parser.parse(data: data)
            } catch {
                throw NetworkRequestError.decodingFailed(underlying: error)
            }
            
        } catch let error as NetworkRequestError {
            throw error
        } catch {
            throw NetworkRequestError.requestFailed(underlying: error)
        }
    }
}

