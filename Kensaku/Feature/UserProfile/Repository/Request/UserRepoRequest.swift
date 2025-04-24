//
//  UserRepoRequest.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

final class UserRepoRequest: NetworkServiceRequest {
    var requestType: RequestType = .get
    var path: String { "/users/\(username)/repos" }
    
    private let username: String
   
    init(username: String) {
        self.username = username
    }
}
