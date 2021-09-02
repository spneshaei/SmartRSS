//
//  Loader.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import Foundation
import SystemConfiguration

enum LoaderError: String, Error {
    case wrongURLFormat = "Wrong URL format provided"
    case noInternet = "No Internet"
    case networkError = "Network error"
}

func isInternetAvailable() -> Bool {
    //        return NetworkReachabilityManager()!.isReachable
    //                        let reachability: Reachability = Reachability.reachabilityForInternetConnection()
    //                        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
    //                        return networkStatus != 0
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}

func loadData(from stringURL: String) async throws -> String {
    guard let url = URL(string: stringURL) else { throw LoaderError.wrongURLFormat }
    guard isInternetAvailable() else { throw LoaderError.noInternet }
    return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String, Error>) in
        do {
            continuation.resume(returning: try String(contentsOf: url))
        } catch(let error) {
            print(error.localizedDescription)
            continuation.resume(throwing: LoaderError.networkError)
        }
    }
}
