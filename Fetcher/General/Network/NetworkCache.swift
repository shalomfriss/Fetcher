//
//  NetworkCache.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation


class NetworkCache {
    //MARK:- variables
    let cacheSizeMemory = 500*1024*1024
    let cacheSizeDisk = 0
    let cache:URLCache
    
    public static let shared:NetworkCache = NetworkCache()
    
    //MARK:- initialization
    init() {
        cache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk, diskPath: "nsurlcache")
    }
    
    
    public func getCachedResponse(request: URLRequest) -> Data? {
        if let cachedData = self.cache.cachedResponse(for: request)?.data {
            return cachedData
        } else { return nil }
    }
    
    public func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        cache.storeCachedResponse(cachedResponse, for: request)
    }

}
