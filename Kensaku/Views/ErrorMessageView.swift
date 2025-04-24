//
//  ErrorMessageView.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct ErrorMessageView: View {
    let message: String
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .multilineTextAlignment(.center)
    }
}
