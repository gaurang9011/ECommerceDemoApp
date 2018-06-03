//
//  NetworkManager.swift
//  ECommerceDemoApp
//
//  Created by Gaurang Makwana on 5/31/18.
//  Copyright © 2018 Gaurang Makwana. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import EZLoadingActivity

public typealias ResponseData = [String: Any]
public typealias ResponseArray = [Any]
public typealias FailureMessage = String
public typealias Completion = (() -> ())

class NetworkManager {

    // MARK: - Singleton
    static let shared = NetworkManager()
    
    // A network reachability instance
    let networkReachability = NetworkReachabilityManager()
    
    // MARK: - Custom Functions
    
    // Initialize
    private init() {
        networkReachability?.startListening()
    }
    
    // MARK: - Network Request
    
    func request(_ url: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, success:@escaping ((Any)->Void), failure:@escaping ((FailureMessage)->Void)) {
        
        // check network reachability
        guard (networkReachability?.isReachable)! else {
            
            self.hideIndicator()
            failure(Messages.internetConnection)
            return
        }
        
        // print request url and parameters as JSON String
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters ?? [:], options:.prettyPrinted)
            let paramString = String(data: data,encoding: String.Encoding.utf8)!
            print("url: \(url)")
            print("parameteres: \(paramString)")
        }
        catch {
            print(error.localizedDescription)
        }
        
        // Network request
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response: DataResponse<Any>) in
            
            // hide indicator
            self.hideIndicator()
            
            // check result is success
            guard response.result.isSuccess else {
                let error = (response.error?.localizedDescription)!
                print(error)
                failure(error)
                return
            }
            
            // check if data is present
            guard let responseObject = response.result.value as? ResponseData else {
                success([:])
                return
            }
            
            // send data object in completion handler
            success(responseObject)
        }
    }
}

// MARK: Loading Activity
extension NetworkManager {
    
    // Hide indicator
    func hideIndicator() {
        DispatchQueue.main.async {
            EZLoadingActivity.hide()
        }
    }
    
    //Show Indiactor
    func showIndicator() {
        DispatchQueue.main.async {
            EZLoadingActivity.show("Please wait...", disableUI: true)
        }
    }
}
