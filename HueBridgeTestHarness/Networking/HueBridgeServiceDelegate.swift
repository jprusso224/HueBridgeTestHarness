//
//  HueBridgeServiceDelegate.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import Foundation

enum AddressResolutionStatus : String
{
    case Waiting
    case Resolved
    case TimedOut
}

class HueBridgeServiceDelegate: NSObject, NetServiceDelegate
{
    private var status: AddressResolutionStatus = AddressResolutionStatus.Waiting
    private var active: Bool = true;
    
    func netServiceDidResolveAddress(_ sender: NetService)
    {
        status = AddressResolutionStatus.Resolved
    }
    
    func netServiceDidStop(_ sender: NetService)
    {
        active = false
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber])
    {
        //No address was resolved.
        status = AddressResolutionStatus.TimedOut
    }
    
    func getAddressResolutionState() -> AddressResolutionStatus
    {
        return status
    }
}
