//
//  UserListView.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 23.04.25.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModelImpl()
    
    var body: some View {
        NavigationStack {
            listView()
                .navigationTitle(viewModel.navigationTitle)
                .task {
                    await viewModel.fetchUsers()
                }
                .overlay {
                    loadingView()
                    errorView()
                }
        }
    }
}

private extension UserListView {
    
    // MARK: - List View
    @ViewBuilder
    func listView() -> some View {
        List(viewModel.users) { userViewData in
            NavigationLink(destination: UserProfileView(username: userViewData.username)) {
                UserListItemView(userViewData: userViewData)
            }
        }
    }
    
    // MARK: - Loading View
    @ViewBuilder
    func loadingView() -> some View {
        if viewModel.isLoading {
            ProgressView()
        }
    }
    
    // MARK: - Error View
    @ViewBuilder
    func errorView() -> some View {
        if let errorMessage = viewModel.errorMessage {
            ErrorMessageView(message: errorMessage)
        }
    }
}

#Preview {
    UserListView()
}
