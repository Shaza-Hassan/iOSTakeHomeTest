//
//  Bundle.swift
//  iOSTakeHomeTest
//
//  Created by Shaza Hassan on 14/08/2024.
//

import Foundation

extension Bundle{
    static func getString(key: String) -> String {
        return main.infoDictionary?[key] as? String ?? ""
    }
    
    static func getStringFromUserDefine(key:String) -> String {
        return main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
}
