//
//  UserProfileRequest.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

final class UserProfileRequest: NetworkServiceRequest {
    var requestType: RequestType = .get
    var path: String { "/users/\(username)" }
    
    private let username: String
   
    init(username: String) {
        self.username = username
    }
}
