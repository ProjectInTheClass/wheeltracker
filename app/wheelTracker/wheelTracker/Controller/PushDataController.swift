//
//  PushDataController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/06/30.
//

import Foundation

public func storePushDatas(){
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    
    do{
        let data = try jsonEncoder.encode(pushDatas)
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectoryUrl.appendingPathComponent("pushData.json")
        
        do{
            try data.write(to: fileURL)
        }
        catch let error as NSError {
            print(error)
        }
        
    } catch{
        print(error)
    }
}

public func loadPushDatas(){
    let jsonDecoder = JSONDecoder()
    
    do {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectoryUrl.appendingPathComponent("pushData.json")
        
        let jsonData = try Data(contentsOf: fileURL, options: .mappedIfSafe)
        
        let decodedData = try jsonDecoder.decode([PushData].self, from: jsonData)
        
        pushDatas = decodedData
        
    }
    catch{
        print(error)
        return
    }
}
