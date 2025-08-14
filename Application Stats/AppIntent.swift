//
//  AppIntent.swift
//  Application Stats
//
//  Created by Anshul Shandilya on 8/13/25.
//

import WidgetKit
import AppIntents

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
