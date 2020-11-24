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
    
    private var active: Bool = true
    
    var status: AddressResolutionStatus = AddressResolutionStatus.Waiting
    var formattedAddresses: [String] = []
    
    //Callback to notify that IP addresses have been resolved.
    //Use this function to convert and cache the addresses into strings
    func netServiceDidResolveAddress(_ sender: NetService)
    {
        let unwrappedAddresses: [Data] = sender.addresses ?? []
            
        //For Data object in the array.
        for address in unwrappedAddresses
        {
            var formattedAddress: String = ""
            
            //Create an iterator to iterator over the bytes in the address.
            var iter: Data.Iterator = address.makeIterator()
        
            //Start with the first byte
            var currentByte: UInt8? = iter.next()
            
            //While iter.next doesn't return nil,
            //append byte to the formatted address string.
            while(currentByte != nil)
            {
                formattedAddress.append("\(currentByte!).")
                currentByte = iter.next()
            }
            
            //Finally drop the last '.' that was added and append
            //to the array of formatted addresses.
            formattedAddresses.append(String(formattedAddress.dropLast()))
        }
        
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
}
