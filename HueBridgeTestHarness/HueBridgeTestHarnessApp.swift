//
//  HueBridgeTestHarnessApp.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import SwiftUI

@main
struct HueBridgeTestHarnessApp: App {
    
    var client = HueBridgeClient()
    
    var body: some Scene {
        WindowGroup {
            ContentView(client: client, browserDelegate: client.browserDelegate)
        }
    }
}
