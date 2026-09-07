//
//  CheckInModel.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//

import Foundation
struct CheckInModel:Identifiable{
    let id:UUID
    let latitude:Double
    let longitude:Double
    let timeStamp:Date
    
    init(id: UUID = UUID(), latitude: Double, longitude: Double, timeStamp: Date = .now) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.timeStamp = timeStamp
    }
}
