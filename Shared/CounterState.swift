//
//  CounterState.swift
//  Shared
//
//  Created by Anshul Shandilya on 8/13/25.
//

import Foundation
import WidgetKit

struct CounterState {
    static let counterKey = "dailyCounter"
    static let lastResetKey = "lastResetDate"
    static let historyKey = "dailyHistory" // NEW

    static func currentCount() -> Int {
        let lastReset = UserDefaults.standard.object(forKey: lastResetKey) as? Date ?? Date.distantPast
        if !Calendar.current.isDateInToday(lastReset) {
            saveToHistory(count: UserDefaults.standard.integer(forKey: counterKey))
            UserDefaults.standard.set(0, forKey: counterKey)
            UserDefaults.standard.set(Date(), forKey: lastResetKey)
            return 0
        }
        return UserDefaults.standard.integer(forKey: counterKey)
    }

    static func updateCount(by delta: Int) {
        let count = max(0, currentCount() + delta)
        UserDefaults.standard.set(count, forKey: counterKey)
        UserDefaults.standard.set(Date(), forKey: lastResetKey)
        WidgetCenter.shared.reloadAllTimelines()
    }

    private static func saveToHistory(count: Int) {
        var history = UserDefaults.standard.dictionary(forKey: historyKey) as? [String: Int] ?? [:]
        let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
        history[dateString] = count
        UserDefaults.standard.set(history, forKey: historyKey)
    }
}
