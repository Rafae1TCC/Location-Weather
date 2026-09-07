//
//  LocationService.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//

import Foundation
import CoreLocation
import Combine

class LocationService:NSObject,ObservableObject,CLLocationManagerDelegate{
    private let manager:CLLocationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    
    @Published var isLoading: Bool = false
    
    @Published var authStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        
        super.init()
        
        manager.delegate = self
        
        //Select type of accuracy
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        authStatus = manager.authorizationStatus
        
    }
    
    //Get current location
    func requestLocation(){
        isLoading = true
        manager.requestLocation()
    }
    
    func requestPermissionAndLocation(){
        authStatus = manager.authorizationStatus
        
        if authStatus == .notDetermined{
            manager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            requestLocation()
            return
        }
    }
    
    //MARK: Template Functions from CLLocationManagerDelegates
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        if let lastLocation = locations.last{
            location = lastLocation.coordinate
        }
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error){
        isLoading = false
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authStatus = manager.authorizationStatus
        
        if authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways{
            requestLocation()
        } else {
            isLoading = false
        }
        
    }
    
    
    
}
