//
//  EnvironmentInterceptor.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Alamofire

//MARK: - EnvironmentInterceptor
struct EnvironmentInterceptor: RequestInterceptor {
    
    //MARK: - Methods
    func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("🚀 Running request: \(urlRequest.httpMethod ?? "") - \(urlRequest.url?.absoluteString ?? "")")
        
        return completion(.success(urlRequest))
    }
}
