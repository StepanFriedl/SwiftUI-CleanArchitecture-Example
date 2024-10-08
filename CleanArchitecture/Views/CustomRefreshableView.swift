//
//  CustomRefreshableView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import SwiftUI

struct CustomRefreshableView<Content: View>: View {
    @State private var isRefreshing = false
    @State private var dragOffset: CGFloat = 0
    private let threshold: CGFloat = 0
    let content: () -> Content
    let onRefresh: () -> Void
    
    var body: some View {
        VStack {
            if isRefreshing {
                ProgressView("Refreshing...")
                    .padding(.top, 10)
            }
            
            content()
                .background(GeometryReader { geo in
                    Color.clear
                        .preference(key: OffsetKey.self, value: geo.frame(in: .global).minY)
                })
                .onPreferenceChange(OffsetKey.self) { minY in
                    if minY > threshold && !isRefreshing {
                        dragOffset = minY - threshold
                    } else {
                        dragOffset = 0
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 0 {
                                dragOffset = value.translation.height
                            }
                        }
                        .onEnded { value in
                            if dragOffset > threshold && !isRefreshing {
                                isRefreshing = true
                                onRefresh()
                                // Simulate the end of the refresh process after a delay
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isRefreshing = false
                                }
                            }
                            dragOffset = 0
                        }
                )
        }
        .offset(y: dragOffset)
    }
}

private struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
