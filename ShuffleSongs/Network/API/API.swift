import UIKit
import Foundation

class API: APICore {
    
    func requestObject<T>(from endpoint: APIRequest, type: T.Type, completion: @escaping  CompletionCallback<T>) where T : Output {
        
        request(from: endpoint.url,
                params: endpoint.params,
                type: type,
                method: endpoint.method,
                completion: completion)
        
    }
    
    private func request<T: Decodable>(from endpoint: String,
                                       params: [String: String],
                                       type: T.Type,
                                       method: HttpMethod,
                                       completion: @escaping CompletionCallback<T>) {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let pathURL = endpoint
        
        var baseURL = URLComponents(string: pathURL)
        baseURL?.queryItems = []
        params.forEach { baseURL?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value)) }
        
        guard let url = baseURL?.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        var request : URLRequest = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let dataType = try decoder.decode(type.self, from: data)
                    completion(.success(dataType))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            }
            }.resume()
    }
    
    static func requestImage(from imagePath: String,  completion: @escaping RequestImageResult) {
        if let image = ImageLoader.shared.cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
        } else {
            guard let url = URL(string: imagePath) else {
                completion(.failure(.invalidData))
                return
            }
            DispatchQueue.global().async {
                do {
                    let data = try Data(contentsOf: url)
                    guard let image = UIImage(data: data) else {
                        completion(.failure(.invalidData))
                        return
                    }
                    
                    DispatchQueue.main.async {
                        ImageLoader.shared.cache.setObject(image, forKey: imagePath as NSString)
                        completion(.success(image))
                    }
                } catch {
                    completion(.failure(.invalidData))
                }
            }
        }
    }
}

