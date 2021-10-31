//
//  ImageCache.swift
//  Fetcher
//
//  Created by Shalom Friss on 10/31/21.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func getCachedImage(_ url:URL) -> UIImage?
    func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID?
    func cancelLoad(_ uuid: UUID)
}

public class ImageCache: ImageCacheProtocol {
    
    public static let shared        = ImageCache()
    private var cachedImages        = [URL: UIImage]()
    private var runningRequests     = [UUID: URLSessionDataTask]()
    
    public func getCachedImage(_ url:URL) -> UIImage? {
        if let cachedImage = cachedImages[url] {
            return cachedImage
        }
        return nil
    }
    
    final func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        
        //Check for the cached image
        if let cachedImage = cachedImages[url] {
            completion(.success(cachedImage))
            return nil
        }
        
        //A token to identify this load operation
        let uuid = UUID()
        
        //Run the data task
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            
            defer {self.runningRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
              self.cachedImages[url] = image
              completion(.success(image))
              return
            }
            
            //Check for an error
            guard error != nil else {
                print("***************************")
                print("ERROR")
                print(error ?? "An error occured")
                print("***************************")
                return
            }
        }
        task.resume()
        
        runningRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
}

