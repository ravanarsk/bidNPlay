//
//  NetworkManager.swift
//  Ikin Fleet
//
//  Created by Ashin Asok on 13/06/23.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    private init() {}
    
    // Define a completion handler type for API responses
    typealias CompletionHandler<T> = (Result<T, Error>) -> Void
    
}

//MARK: Get Request
extension NetworkManager{
    
    /**
     Performs a GET request to the specified URL with optional parameters and decodes the response into the specified response type.
     
     - Parameters:
        - urlString: The URL string of the API endpoint to request.
        - params: Optional parameters to include in the request. Default is `nil`.
        - responseType: The type of the response object to be decoded from the API response.
     
     - Returns: The completion handler to be called when the request is completed. It provides a `Result` object with the decoded response object on success or an error on failure.
     
     - Warning: The completion handler is executed on the URLSession delegate queue. Make sure to handle any UI updates on the main queue if needed.
     
     - Note: This function sends a GET request to the provided URL with the given request body data. The response object is expected to be of the specified `responseType`. The completion handler is called with the result of the request.
     
     */
    
    func get<T: Decodable>(urlString: String, params: [String: Any?]? = nil, responseType: T.Type, completion: @escaping CompletionHandler<T>) {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        // Add parameters to URL query string if provided
        if let parameters = params {
            urlComponents.queryItems = parameters.map { key, value in
                URLQueryItem(
                    name: key,
                    value: value.flatMap { "\($0)" } ?? "null"
                )
            }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let token = DefaultWrapper().getStringFrom(Key: Keys.tokenID)
        if token != ""{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let responseError = self.handleResponseError(
                    response: response, data: data
                )
                if let responseErr = responseError{
                    completion(.failure(responseErr))
                }else{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(responseType, from: data)
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
        
    }
    
}

//MARK: POST Request
extension NetworkManager{
    
    /**
     Performs a POST request to the specified URL with optional parameters and decodes the response into the specified response type.
     
     - Parameters:
        - urlString: The URL string of the API endpoint to request.
        - params: Optional parameters to include in the request. Default is `nil`.
        - responseType: The type of the response object to be decoded from the API response.
     
     - Returns: The completion handler to be called when the request is completed. It provides a `Result` object with the decoded response object on success or an error on failure.
     
     - Warning: The completion handler is executed on the URLSession delegate queue. Make sure to handle any UI updates on the main queue if needed.
     
     - Note: This function sends a POST request to the provided URL with the given request body data. The response object is expected to be of the specified `responseType`. The completion handler is called with the result of the request.
     
     */
    func post<T: Decodable>(urlString: String, params: [String: Any?]? = nil, responseType: T.Type, completion: @escaping CompletionHandler<T>){
        
        // get url from url string passed as parameter to this function.
        guard let url = URL(string: urlString) else{
            completion(.failure(NetworkError.urlError))
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let token = DefaultWrapper().getStringFrom(Key: Keys.tokenID)
        if token != ""{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
//        if let parameters = params {
//            let formData = parameters.map {
//                "\($0.key)=\($0.value)"
//            }.joined(separator: "&")
//            request.httpBody = formData.data(using: .utf8)
//            debugPrint(formData)
//        }
        if let parameters = params {
            
            var formData = ""
            for (key, value) in parameters {
                let encodedValue : String
                if let unwrappedValue = value {
                    // Encode the non-nil value
                    encodedValue = "\(unwrappedValue)"
                        .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?
                        .replacingOccurrences(of: "+", with: "%2B") ?? ""
                } else {
                    // Represent nil as "null"
                    encodedValue = "null"
                }
                formData += "\(key)=\(encodedValue)&"
            }
            formData.removeLast() // Remove trailing "&"
            request.httpBody = formData.data(using: .utf8)
            debugPrint(formData)
            
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let responseError = self.handleResponseError(
                    response: response, data: data
                )
                if let responseErr = responseError{
                    completion(.failure(responseErr))
                }else{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(responseType, from: data)
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
}

//MARK: DELETE Request
extension NetworkManager{
    
    func delete<T: Decodable>(urlString: String, params: [String: Any]? = nil, responseType: T.Type, completion: @escaping CompletionHandler<T>) {
        
        guard let url = URL(string: urlString) else{
            completion(.failure(NetworkError.urlError))
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let token = DefaultWrapper().getStringFrom(Key: Keys.tokenID)
        if token != ""{
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let parameters = params {
            let formData = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            request.httpBody = formData.data(using: .utf8)
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let responseError = self.handleResponseError(
                    response: response, data: data
                )
                if let responseErr = responseError{
                    completion(.failure(responseErr))
                }else{
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(responseType, from: data)
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
}

//MARK: Handle HTTPResponse Errors
extension NetworkManager{
    
    fileprivate func handleResponseError(response : URLResponse? , data : Data) -> NSError?{
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return NetworkError.invalidResponse
        }
        let statusCode = httpResponse.statusCode
        debugPrint("HTTP Status Code : \(statusCode)")
        if statusCode == 200{
            return nil
        }
        
        do{
            let decoder = JSONDecoder()
            let responseObject = try decoder.decode(BasicNetworkModel.self, from: data)
            let resErr = NSError(
                domain: ErrorDomains.networkError,
                code: statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey: responseObject.message ?? NetworkErrConstants.unknownServer
                ]
            )
            return resErr
        }catch{
            return NetworkError.dataCorrupt
        }
        
    }
    
}

//MARK: Post with raw data
extension NetworkManager{
    
    func postWithRaw<T: Decodable>(urlString: String, params: [String: Any]? = nil, responseType: T.Type, completion: @escaping CompletionHandler<T>) {
        // Get URL from the URL string passed as a parameter to this function.
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        
        // Create the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let token = DefaultWrapper().getStringFrom(Key: Keys.tokenID)
        if token != "" {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            request.addValue("Bearer IKIN_!@#", forHTTPHeaderField: "Authorization")
        }
        
        if let parameters = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let responseError = self.handleResponseError(response: response, data: data)
                if let responseErr = responseError {
                    completion(.failure(responseErr))
                } else {
                    let decoder = JSONDecoder()
                    let responseObject = try decoder.decode(responseType, from: data)
                    completion(.success(responseObject))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
}
