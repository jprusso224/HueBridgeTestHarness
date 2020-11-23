//
//  ContentView.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import SwiftUI

struct ContentView: View {
    
    var client: HueBridgeClient
    @ObservedObject var browserDelegate: HueBridgeBrowserDelegate
    
    var body: some View {
        VStack
        {
            Text("Discovered Services").padding()
            
            NavigationView
            {
                List(browserDelegate.discoveredServices, id: \.name)
                {
                    discoveredService in
                    NavigationLink(
                        destination: HueBridgeServiceView(discoveredService: discoveredService),
                        label: {
                            Text("\(discoveredService.name)")
                        })
                }
            }
            
            HStack
            {
                Button(action:
                        {
                            client.start()
                        })
                {
                    Text("Start")
                }
                
                Button(action:
                        {
                            client.stop()
                        })
                {
                    Text("Stop")
                }
            }
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let client = HueBridgeClient()
    static var previews: some View {
        ContentView(client: client, browserDelegate: client.browserDelegate)
    }
}
