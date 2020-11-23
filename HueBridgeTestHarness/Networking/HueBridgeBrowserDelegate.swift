//
//  HueBridgeBrowserDelegate.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import Foundation

struct DiscoveredService
{
    var name: String
    var service: NetService
    var delegate: HueBridgeServiceDelegate
}

class HueBridgeBrowserDelegate : NSObject, NetServiceBrowserDelegate, ObservableObject
{
    var DEFAULT_ADDRESS_RESOLUTION_TIMEOUT_SEC: TimeInterval = 5
    
    @Published var discoveredServices: [DiscoveredService] = []
    
    private var targetHueBridgeServiceName: String = ""
    
    //Callback provided by NetServiceBrowserDelegate
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool)
    {
        //Create a new service delegate.
        let delegate = HueBridgeServiceDelegate()
        
        //Assign the delegate to the service.
        service.delegate = delegate
        
        //Command the service to resolve the address.
        service.resolve(withTimeout: DEFAULT_ADDRESS_RESOLUTION_TIMEOUT_SEC)
        
        //Append a DiscoveredService object with a name, service, and delegate.
        discoveredServices.append(DiscoveredService(name: service.name, service: service, delegate: delegate))
    }
    
    //The user should call this to set the target.
    //Note the user should first choose between the available services.
    //Returns a bool to prevent the user from selecting an invalid service name.
    func setTargetHueBridgeService(serviceName: String) -> Bool
    {
        var set: Bool = false
        
        for discoveredService in discoveredServices
        {
            //Check if service name was found (is valid)
            if(targetHueBridgeServiceName == discoveredService.name)
            {
                targetHueBridgeServiceName = serviceName
                set = true
                break //Exit the loop once a valid name is found
            }
        }
        
        return set
    }
    
    //Use this function to reset the cached information regarding the discovered services.
    func reset()
    {
        discoveredServices = []
        targetHueBridgeServiceName = ""
    }
    
}

