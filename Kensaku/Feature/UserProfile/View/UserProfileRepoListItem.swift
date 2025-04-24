//
//  UserProfileRepoListItem.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct UserProfileRepoListItem: View {
    let repo: UserRepoViewData
    var body: some View {
        VStack(alignment: .leading, spacing: LayoutConstants.Spacing.three) {
            HStack {
                Text(repo.name)
                    .font(.headline)
                Spacer()
                HStack {
                    Image.starFill
                        .foregroundStyle(.yellow)
                    Text(repo.stars)
                }
            }
            
            if !repo.language.isEmpty {
                Text(repo.language)
                    .font(.subheadline)
                    .padding(.horizontal, LayoutConstants.Spacing.three)
                    .padding(.vertical, LayoutConstants.Spacing.two)
                    .background(Color.secondary.opacity(0.2))
                    .clipShape(Capsule())
            }
            
            if !repo.description.isEmpty {
                Text(repo.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.CornerRadius.large))
    }
}
