
import Foundation
import UIKit

typealias ImageCacheLoaderCompletionHandler = ((UIImage) -> ())

class ImageLoader {
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<NSString, UIImage>!
    
    private init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
    
    static private(set) var shared = ImageLoader()
}
