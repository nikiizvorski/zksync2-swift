//
//  IL1Messenger.swift
//  ZkSync2
//
//  Created by Bojan on 5.7.23..
//

import Foundation
#if canImport(web3swift)
import web3swift
#else
import web3swift_zksync2
#endif

public extension Web3.Utils {
    
    static var IL1Messenger: String? {
        guard let path = Bundle.main.path(forResource: "IL1Messenger", ofType: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else {
            return nil
        }
        
        guard let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
            return nil
        }
        
        guard let json = jsonResult as? [String: Any], let abi = json["abi"] as? [[String: Any]] else { return nil
        }
        
        guard let abiData = try? JSONSerialization.data(withJSONObject: abi, options: []) else {
            return nil
        }
    
        return String(data: abiData, encoding: .utf8)
    }
}
