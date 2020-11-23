//
//  HueBridgeClient.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import Foundation



class HueBridgeClient
{
    let HUE_SERVICE_DOMAIN: String = "local."
    let HUE_SERVICE_TYPE: String = "_hue._tcp"
    
    var browserDelegate = HueBridgeBrowserDelegate()
    var browser = NetServiceBrowser()
    
    func start()
    {
        browser.delegate = browserDelegate
        browser.searchForServices(ofType: HUE_SERVICE_TYPE, inDomain: HUE_SERVICE_DOMAIN)
        print("Starting the client!")
    }
    
    func stop()
    {
        browser.stop()
        browserDelegate.reset()
        print("Stopping the client!")
    }
}

