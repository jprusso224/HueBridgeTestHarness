//
//  HueBridgeServiceView.swift
//  HueBridgeTestHarness
//
//  Created by John Paul Russo on 11/23/20.
//

import SwiftUI

struct DiscoveredServiceInfoListItem: View
{
    var valueName: String
    var valueText: String
    
    var body: some View {
        HStack
        {
            Text(valueName).padding()
            Spacer()
            Text(valueText).padding()
        }
    }
}

struct HueBridgeServiceView: View {
    
    var discoveredService: DiscoveredService
    
    var body: some View {
        DiscoveredServiceInfoListItem(valueName: "Name:",
                                      valueText: discoveredService.name)
        DiscoveredServiceInfoListItem(valueName: "Description:",
                                      valueText: discoveredService.service.description)
        DiscoveredServiceInfoListItem(valueName: "Hostname:",
                                      valueText: String(discoveredService.service.hostName ?? "Unknown"))
        DiscoveredServiceInfoListItem(valueName: "Port:",
                                      valueText: String(discoveredService.service.port))
        DiscoveredServiceInfoListItem(valueName: "Address Resolution State:",
                                      valueText: discoveredService.delegate.getAddressResolutionState().rawValue)
    }
}

struct HueBridgeServiceView_Previews: PreviewProvider {
    
    static let ds = DiscoveredService(name: "FakeName", service: NetService(), delegate: HueBridgeServiceDelegate())
    
    static var previews: some View {
        HueBridgeServiceView(discoveredService: ds)
    }
}
