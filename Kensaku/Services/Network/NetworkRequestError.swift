//
//  NetworkRequestError.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

enum NetworkRequestError: LocalizedError {
    case invalidURL
    case requestFailed(underlying: Error)
    case invalidResponse
    case statusCode(Int)
    case decodingFailed(underlying: Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is malformed."
        case let .requestFailed(error):
            return "The network request failed: \(error.localizedDescription)"
        case .invalidResponse:
            return "The response from the server was invalid."
        case let .statusCode(code):
            return "Server returned an error with status code \(code)."
        case let .decodingFailed(error):
            return "Failed to parse the response: \(error.localizedDescription)"
        }
    }
}

