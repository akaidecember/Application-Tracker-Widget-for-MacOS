//
//  Application_Stats.swift
//  Application Stats
//
//  Created by Anshul Shandilya on 8/13/25.
//

import WidgetKit
import SwiftUI
import AppIntents


struct CounterEntry: TimelineEntry {
    let date: Date
    let count: Int
    let quote: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: Date(), count: 0, quote: "Keep going, you're doing great!")
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> ()) {
        let entry = CounterEntry(
            date: Date(),
            count: CounterState.currentCount(),
            quote: "Keep going, you're doing great!"
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CounterEntry>) -> ()) {
        let entry = CounterEntry(
            date: Date(),
            count: CounterState.currentCount(),
            quote: "Keep going, you're doing great!"
        )

        // Refresh at midnight to reset counter
        let nextUpdate = Calendar.current.startOfDay(for: Date().addingTimeInterval(86400))
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ApplicationStatsEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 10) {
            // Current Date
            Text(entry.date, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)

            // Quote
            Text(entry.quote)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Counter with +/- buttons
            HStack {
                Button(intent: DecrementCounterIntent()) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                }
                Spacer()
                Text("\(entry.count)")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button(intent: IncrementCounterIntent()) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
        .widgetURL(URL(string: "jobappcounter://history"))
    }
}

struct Application_Stats: Widget {
    let kind: String = "Application_Stats"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            ApplicationStatsEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Counter")
        .description("Track your daily tally with ease.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Application_Stats_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationStatsEntryView(entry: CounterEntry(
            date: Date(),
            count: 5,
            quote: "Keep going, you're doing great!"
        ))
        .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
