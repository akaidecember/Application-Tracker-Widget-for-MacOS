//
//  Application_Stats.swift
//  Application Stats
//
//  Created by Anshul Shandilya on 8/13/25.
//

import WidgetKit
import SwiftUI
import AppIntents

// MARK: - Timeline Provider
struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),
                    quote: "Keep going, you're doing great!",
                    count: CounterState.currentCount())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(),
                    quote: "Keep going, you're doing great!",
                    count: CounterState.currentCount())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        let entry = SimpleEntry(date: Date(),
                                quote: "Keep going, you're doing great! Don't give up.",
                                count: CounterState.currentCount())
        let midnight = Calendar.current.startOfDay(for: Date().addingTimeInterval(86400))
        return Timeline(entries: [entry], policy: .after(midnight))
    }
}

// MARK: - Timeline Entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let quote: String
    let count: Int
}

// MARK: - Widget UI
struct Application_StatsEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        VStack(spacing: 8) {
            Text(entry.date, style: .date)
                .font(.headline)
            
            Text(entry.quote)
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack {
                Button(intent: DecrementCounterIntent()) {
                    Text("–")
                        .font(.largeTitle)
                        .padding()
                }
                Spacer()
                Text("\(entry.count)")
                    .font(.system(size: 36, weight: .bold))
                Spacer()
                Button(intent: IncrementCounterIntent()) {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                }
            }
        }
        .padding()
    }
}

// MARK: - Widget Configuration
struct Application_Stats: Widget {
    let kind: String = "Application_Stats"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: ConfigurationAppIntent.self,
                               provider: Provider()) { entry in
            Application_StatsEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
