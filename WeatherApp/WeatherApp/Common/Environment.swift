//
//  Environment.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import Foundation

//MARK: - Environment
struct Environment {
    
    // MARK: - PlistKey
    enum PlistKey: String {
        case serverUrl = "server_url"
    }
    
    // MARK: - Private Methods
    private static var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }
    
    // MARK: - Static Methods
    static func configuration(_ key: PlistKey) -> String {
        (infoDict["App configuration"] as! [String: Any])[key.rawValue] as! String
    }
    
    static func appName() -> String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
    }
}
