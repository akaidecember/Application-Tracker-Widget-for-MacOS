//
//  CounterState.swift
//  Job App Counter
//
//  Created by Anshul Shandilya on 8/13/25.
//

import SwiftUI
import WidgetKit

struct CounterState {
    static let counterKey = "dailyCounter"
    static let lastResetKey = "lastResetDate"

    static func currentCount() -> Int {
        let lastReset = UserDefaults.standard.object(forKey: lastResetKey) as? Date ?? Date.distantPast
        if !Calendar.current.isDateInToday(lastReset) {
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
}
