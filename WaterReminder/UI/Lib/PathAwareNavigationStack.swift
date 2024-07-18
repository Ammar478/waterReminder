//
//  PathAwareNavigationStack.swift
//  WaterReminder
//
//  Created by Ammar Alsanani on 16/07/2024.
//

import SwiftUI

struct PathAwareNavigationStack<Content: View>: View {
    private let content: @MainActor (Binding<NavigationPath>) -> Content
    @State private var path: NavigationPath
    
    init(path: NavigationPath, @ViewBuilder content: @MainActor @escaping (Binding<NavigationPath>) -> Content) {
        self._path = .init(initialValue: path)
        self.content = content
    }
    
    init(@ViewBuilder content: @MainActor @escaping (Binding<NavigationPath>) -> Content) {
        self._path = .init(initialValue: .init())
        self.content = content
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            content($path)
        }
    }
}

extension NavigationPath {
    mutating func pop() {
        guard !isEmpty else { return }
        removeLast()
    }
    mutating func removeAll() {
        removeLast(count)
    }
}

#Preview {
    struct PushPopView: View {
        @Binding var path: NavigationPath
        var level: Int { path.count }
        
        init(path: Binding<NavigationPath>) {
            self._path = path
        }
        
        var body: some View {
            VStack {
                NavigationLink("Push by navigation link", value: UUID())
                Button("Push by append") {
                    path.append(UUID())
                }
                Button("Pop") {
                    path.pop()
                }
                Button("Back to Root") {
                    path.removeAll()
                }
            }
            .navigationDestination(for: UUID.self) { _ in
                PushPopView(path: _path)
            }
            .navigationTitle("Level \(level)")
        }
    }
    
    return PathAwareNavigationStack { PushPopView(path: $0) }
}
