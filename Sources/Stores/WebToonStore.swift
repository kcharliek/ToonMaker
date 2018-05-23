//
//  WebToonStore.swift
//  ToonMaker
//
//  Created by CHANHEE KIM on 2018. 5. 9..
//  Copyright © 2018년 CHK. All rights reserved.
//

import Foundation

class WebToonStore {
    // MARK: - Singleton
    static let shared = WebToonStore()
    private let WebToonStoreKey: String = "webToonData"
    
    private init() {
        //Initialize UserDefaults
        if let _ = UserDefaults.standard.object(forKey: WebToonStoreKey) as? Data {}
        else {
            let newArray = [WebToon]()
            let newArrayData = NSKeyedArchiver.archivedData(withRootObject: newArray)
            UserDefaults.standard.set(newArrayData, forKey: WebToonStoreKey)
        }
    }
    
    // MARK: - Method
    func fetchAllWebToons() -> [WebToon]? {
        if let webToonData = UserDefaults.standard.object(forKey: WebToonStoreKey) as? Data {
            let webToons = NSKeyedUnarchiver.unarchiveObject(with: webToonData) as? [WebToon]
            return webToons
        }else{
            return nil
        }
    }
    
    func save(webToon: WebToon) -> Bool {
        guard var allWebToons = fetchAllWebToons() else { return false }
        webToon.modifiedDate = Date()
        
        if let existOneIndex = allWebToons.index(where: { $0.creationDate == webToon.creationDate }) {
            allWebToons[existOneIndex] = webToon
        }else {
            allWebToons.append(webToon)
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: allWebToons)
        UserDefaults.standard.set(data, forKey: WebToonStoreKey)
        print("Successfully Data Saved")
        return true
    }
    
    func remove(webToon: WebToon) -> Bool {
        guard var allWebToons = fetchAllWebToons() else { return false }
        
        if let existOneIndex = allWebToons.index(where: { $0.creationDate == webToon.creationDate }) {
            allWebToons.remove(at: existOneIndex)
        }else {
            return false
        }
        
        let data = NSKeyedArchiver.archivedData(withRootObject: allWebToons)
        UserDefaults.standard.set(data, forKey: WebToonStoreKey)
        
        return true
    }
}
