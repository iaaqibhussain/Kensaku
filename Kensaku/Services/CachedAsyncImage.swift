//
//  CachedAsyncImage.swift
//  Kensaku
//
//  Created by Syed Muhammad Aaqib Hussain on 24.04.25.
//

import SwiftUI

struct CachedAsyncImage<I: View, P: View>: View {
    private let url: URL?
    private let scale: CGFloat
    private let content: (Image) -> I
    private let placeholder: () -> P
    
    @State private var phase: AsyncImagePhase = .empty
    
    init(
        url: URL?,
        scale: CGFloat = 1,
        @ViewBuilder content: @escaping (Image) -> I,
        @ViewBuilder placeholder: @escaping () -> P
    ) {
        self.url = url
        self.scale = scale
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        Group {
            switch phase {
            case .empty:
                placeholder()
            case .failure:
                placeholder()
            case .success(let image):
                content(image)
            @unknown default:
                placeholder()
            }
        }
        .task {
            await loadImage()
        }
    }
}

private extension CachedAsyncImage {
    func loadImage() async {
        guard case .empty = phase, let url = url else { return }
        
        let request = URLRequest(url: url)
        
        // Check cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: request),
           let uiImage = UIImage(data: cachedResponse.data) {
            let image = Image(uiImage: uiImage)
            phase = .success(image)
            return
        }
        
        // Download and cache
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                phase = .success(image)
                
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
            } else {
                phase = .failure(URLError(.cannotDecodeContentData))
            }
        } catch {
            phase = .failure(error)
        }
    }
}
