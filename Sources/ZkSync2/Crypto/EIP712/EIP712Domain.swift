//
//  Eip712Domain.swift
//  ZkSync2
//
//  Created by Maxim Makhun on 8/14/22.
//

import Foundation
import BigInt
#if canImport(web3swift)
import web3swift
#else
import web3swift_zksync2
#endif

public class EIP712Domain: Structurable {
    
    static let name = "zkSync"
    
    static let version = "2"
    
    public let name: String
    
    public var version: String
    
    public let chainId: EIP712.UInt256
    
    public var verifyingContract: EIP712.Address? = nil
    
    init(_ chainId: ZkSyncNetwork) {
        self.name = EIP712Domain.name
        self.version = EIP712Domain.version
        self.chainId = EIP712.UInt256(chainId.rawValue)
    }
    
    public init(_ chainId: EIP712.UInt256) {
        self.name = EIP712Domain.name
        self.version = EIP712Domain.version
        self.chainId = chainId
    }
    
    public init(_ name: String, version: String, chainId: EIP712.UInt256) {
        self.name = name
        self.version = version
        self.chainId = chainId
    }
    
    init(_ name: String, version: String, chainId: ZkSyncNetwork, address: String) {
        self.name = name
        self.version = version
        self.chainId = EIP712.UInt256(chainId.rawValue)
        
        guard let ethereumAddress = EthereumAddress(address) else {
            fatalError("Invalid address.")
        }
        
        self.verifyingContract = ethereumAddress
    }
    
    public init(_ name: String, version: String, chainId: EIP712.UInt256, address: String) {
        self.name = name
        self.version = version
        self.chainId = chainId
        
        guard let ethereumAddress = EthereumAddress(address) else {
            fatalError("Invalid address.")
        }
        
        self.verifyingContract = ethereumAddress
    }
    
    public func getTypeName() -> String {
        return "EIP712Domain"
    }
    
    public func eip712types() -> [zkSync2_swift.EIP712.`Type`] {
        var eip712types: [zkSync2_swift.EIP712.`Type`] = [
            ("name", value: name)
        ]
        
        if !version.isEmpty {
            eip712types.append(("version", value: version))
        }
        
        eip712types.append(("chainId", value: chainId))
        
        if let verifyingContract = verifyingContract {
            eip712types.append(("verifyingContract", value: verifyingContract))
        }
        
        return eip712types
    }
}
