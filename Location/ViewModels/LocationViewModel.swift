//
//  LocationViewModel.swift
//  Location
//
//  Created by Rafael Cabrera on 8/27/26.
//

import Foundation
import Combine
import CoreLocation

enum LocationViewState{
    case needPermission
    case loading
    case ready
    case failed
    case denied
}

class LocationViewModel:ObservableObject {
    @Published var currentViewState:LocationViewState = .needPermission
    @Published var latText: String = ""
    @Published var lonText: String = ""
    @Published var errorMessage:String = ""
    @Published var checkIns:[CheckInModel] = []
    @Published var coordinate: CLLocationCoordinate2D?

    // Called whenever a fresh, valid coordinate becomes available (used to trigger a weather fetch)
    var onLocationReady: ((CLLocationCoordinate2D) -> Void)?

    var locationService: LocationService = LocationService()
    var cancellable:Set<AnyCancellable> = Set<AnyCancellable>()
    init(){
        //Observe the changes from location manager
        //Sensor -> LocationService -> ViewModel -> Views
        //MARK: Publisher and Subscriber pattern
        //Publisher = locationService -> Because this one has the data, and it updates the
        //Subscriber = The one that waits for the change
        self.locationService.objectWillChange.sink{ [weak self] in
            DispatchQueue.main.async{
                if self != nil {
                    self!.updateUIfromService() // my subscriber
                }
            }
        }.store(in: &self.cancellable)
        self.updateUIfromService()
    }
    func updateUIfromService(){
        if self.locationService.isLoading {
            self.currentViewState = .loading
            return
        }
        let status:CLAuthorizationStatus = self.locationService.authStatus
        if status == .notDetermined {
            self.currentViewState = .needPermission
            return
        }
        if status == .denied || status == .restricted {
            self.errorMessage = "Location access off, enable it in settings"
            self.currentViewState = .denied
            return
        }
        if self.locationService.location != nil {
            let coordenate:CLLocationCoordinate2D = self.locationService.location!
            self.latText = String(format: "%0.4f", coordenate.latitude)
            self.lonText = String(format: "%0.4f", coordenate.longitude)
            self.coordinate = coordenate
            self.currentViewState = .ready
            self.onLocationReady?(coordenate)
            return
        }
        self.currentViewState = .failed
        self.errorMessage = "Error: no location"
    }
    func saveCheckIn(){
        if self.locationService.location == nil { return }
        let coordenate = locationService.location!
        let newCheckIn:CheckInModel = CheckInModel(latitude: coordenate.latitude, longitude: coordenate.longitude)
        checkIns.insert(newCheckIn, at: 0)
    }
    func clearAll(){
        self.checkIns.removeAll()
    }
    func enableLocationButton(){
        errorMessage = ""
        currentViewState = .loading
        locationService.requestPermissionAndLocation()
    }
    func refresh(){
        errorMessage = ""
        currentViewState = .loading
        locationService.requestPermissionAndLocation()
    }
}
