//
//  UserListRequest.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import Foundation

final class UserListRequest: NetworkServiceRequest {
    var requestType: RequestType = .get
    
    var path: String { "/users" }
}
