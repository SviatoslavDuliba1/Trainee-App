//
//  UABuilder.swift
//  WeatherApp
//
//  Created by Duliba Sviatoslav on 09.07.2022.
//

import UIKit
//MARK: - Methods
// eg. Darwin/16.3.0
// swiftlint:disable identifier_name
func DarwinVersion() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    let data = Data(bytes: &sysinfo.release, count: Int(_SYS_NAMELEN))
    let dv = String(bytes: data, encoding: .ascii)!
        .trimmingCharacters(in: .controlCharacters)
    return "Darwin/\(dv)"
}
// eg. CFNetwork/808.3
func CFNetworkVersion() -> String {
    let dictionary = Bundle(identifier: "com.apple.CFNetwork")?.infoDictionary!
    let version = dictionary?["CFBundleShortVersionString"] as! String
    return "CFNetwork/\(version)"
}

// eg. iOS/10_1
func deviceVersion() -> String {
    let currentDevice = UIDevice.current
    return "\(currentDevice.systemName)/\(currentDevice.systemVersion)"
}
// eg. iPhone5,2
func deviceName() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    let data = Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN))
    return String(bytes: data, encoding: .ascii)!
        .trimmingCharacters(in: .controlCharacters)
}
// eg. MyApp/1
func appNameAndVersion() -> String {
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as! String
    let name = dictionary["CFBundleName"] as! String
    return "\(name)/\(version)"
}

func UAString() -> String {
    return "\(appNameAndVersion()) \(deviceName()) \(deviceVersion()) \(CFNetworkVersion()) \(DarwinVersion())"
}
// swiftlint:enable identifier_name
