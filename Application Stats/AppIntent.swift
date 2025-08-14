//
//  AppIntent.swift
//  Application Stats
//
//  Created by Anshul Shandilya on 8/13/25.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "This is an example widget." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}

struct IncrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Increment Counter"

    func perform() async throws -> some IntentResult {
        CounterState.updateCount(by: 1)
        return .result()
    }
}

struct DecrementCounterIntent: AppIntent {
    static var title: LocalizedStringResource = "Decrement Counter"

    func perform() async throws -> some IntentResult {
        CounterState.updateCount(by: -1)
        return .result()
    }
}
