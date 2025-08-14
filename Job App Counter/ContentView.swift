//
//  ContentView.swift.swift
//  Job App Counter
//
//  Created by Anshul Shandilya on 8/13/25.
//


import SwiftUI

struct ContentView: View {
    @State private var history: [(date: String, count: Int)] = []

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(history, id: \.date) { entry in
                        HStack {
                            Text(entry.date)
                                .font(.headline)
                            Spacer()
                            Text("\(entry.count)")
                                .font(.title2)
                                .bold()
                        }
                        .padding()
                        .background(Color(NSColor.windowBackgroundColor))
                        .cornerRadius(8)
                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                    }
                }
                .padding()
            }
            .navigationTitle("Daily Tally History")
            .onAppear {
                if let saved = UserDefaults.standard.dictionary(forKey: CounterState.historyKey) as? [String: Int] {
                    history = saved.sorted { $0.key > $1.key }
                        .map { ($0.key, $0.value) }
                }
            }
        }
        .frame(minWidth: 400, minHeight: 500) // macOS sizing
    }
}
