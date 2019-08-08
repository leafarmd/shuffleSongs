import Foundation
import UIKit

class APIStub: APICore {
    
    var url: String?
    var method: HttpMethod?
    var params: [String: String]?
    
    let status: CompletionStatus<Output>
    
    init(status: CompletionStatus<Output>) {
        self.status = status
    }
    
    func requestObject<T>(from endpoint: APIRequest, type: T.Type, completion: @escaping CompletionCallback<T>) where T : Output {
        
        url = endpoint.url
        method = endpoint.method
        params = endpoint.params
    
        switch status {
        case .success(let result):
            completion(.success(result as! T))
        case .failure(let failure):
            completion(.failure(failure))
        }
    }
    
    func requestImage<T>(from request: APIRequest, completion: @escaping (Result<T, RequestError>) -> Void) where T : UIImage {
        
    }
}
