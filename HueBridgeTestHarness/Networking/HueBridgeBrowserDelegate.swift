//
//  HueBridgeBrowserDelegate.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import Foundation

//Utility struct to store the name and pair the service to the delegate.
struct DiscoveredService
{
    var name: String
    var service: NetService
    var delegate: HueBridgeServiceDelegate
}

class HueBridgeBrowserDelegate : NSObject, NetServiceBrowserDelegate, ObservableObject
{
    var DEFAULT_ADDRESS_RESOLUTION_TIMEOUT_SEC: TimeInterval = 5
    
    //publish the list of discovered so listening views get updated with the service details.
    @Published var discoveredServices: [DiscoveredService] = []
    
    //Keep a cache of discovered service names for quick look-up.
    private var discoveredServiceNames: [String] = []
    
    //Eventually this will be set by the user.
    private var targetHueBridgeServiceName: String = ""
    
    //Callback provided by NetServiceBrowserDelegate
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool)
    {
        //Only process the callback for new services, just in case.
        if(!discoveredServiceNames.contains(service.name))
        {
            //Create a new service delegate.
            let delegate = HueBridgeServiceDelegate()
            
            //Assign the delegate to the service.
            service.delegate = delegate
            
            //Command the service to resolve the address.
            service.resolve(withTimeout: DEFAULT_ADDRESS_RESOLUTION_TIMEOUT_SEC)
            
            //Append a DiscoveredService object with a name, service, and delegate.
            discoveredServices.append(DiscoveredService(name: service.name, service: service, delegate: delegate))
            discoveredServiceNames.append(service.name) //Also append the name to the name cache.
        }
    }
    
    //Callback provided by NetServiceBrowserDelegate
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool)
    {
        //TODO: Do more than just print to the console.
        print("Service removed: \(service.name)")
    }
    
    //The user should call this to set the target.
    //Note the user should first choose between the available services.
    //Returns a bool to prevent the user from selecting an invalid service name.
    func setTargetHueBridgeService(serviceName: String) -> Bool
    {
        var set: Bool = false
        
        //Check if service name was found (is valid)
        if(discoveredServiceNames.contains(serviceName))
        {
            targetHueBridgeServiceName = serviceName
            set = true
        }
        
        return set
    }
    
    //Use this function to reset the cached information regarding the discovered services.
    func reset()
    {
        discoveredServices = []
        discoveredServiceNames = []
        targetHueBridgeServiceName = ""
    }
    
}

