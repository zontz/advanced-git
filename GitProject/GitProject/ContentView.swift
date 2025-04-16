//
//  ContentView.swift
//  GitProject
//
//  Created by Владислав Шляховенко on 07.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world! v1")
            Text("Hello, world! v2")
            Text("rebase feature123")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
