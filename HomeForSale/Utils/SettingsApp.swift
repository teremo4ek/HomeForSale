//
//  SettingsApp.swift
//  HomeForSale
//
//  Created by Yury Bely on 08.07.2022.
//

import Foundation

let OrdinaryStartKey = "ordinaryStartKey_app1"

struct SettingsApp {

    static func setOrdinaryStart() {
        UserDefaults.standard.set(true, forKey: OrdinaryStartKey)
        UserDefaults.standard.synchronize()
    }

    static func isOrdinaryStart() -> Bool {
        let defaults = UserDefaults.standard
        let isFirst = defaults.bool(forKey: OrdinaryStartKey)
        return isFirst
    }
}
