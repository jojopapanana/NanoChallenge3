//
//  ContentView.swift
//  NanoChallenge3
//
//  Created by Jovanna Melissa on 17/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var navigationPath = NavigationPath()

        var body: some View {
//            Text("hello world")
            NavigationStack(path: $navigationPath) {
                RecipeView()
                    .navigationDestination(for: String.self) { value in
                        if value == "ChooseInputVew" {
                            ChooseInputView(navigationPath: $navigationPath)
                        }
                    }
            }
        }
}

#Preview {
    ContentView()
}
