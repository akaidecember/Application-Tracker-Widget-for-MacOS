//
//  AppDelegate.swift
//  Job App Counter
//
//  Created by Anshul Shandilya on 8/13/25.
//

import Cocoa
import SwiftUI

import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        openHistoryView()
    }

    func openHistoryView() {
        if window == nil {
            let contentView = ContentView() // <-- Replace with your actual history view

            // Create the window
            window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 500, height: 600),
                styleMask: [.titled, .closable, .resizable, .miniaturizable],
                backing: .buffered,
                defer: false
            )
            window?.center()
            window?.setFrameAutosaveName("HistoryWindow")
            window?.contentView = NSHostingView(rootView: contentView)
        }

        // Show the window and bring app to front
        window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
}
