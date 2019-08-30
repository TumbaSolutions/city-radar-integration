//
//  AppDelegate.swift
//  RadarIntegration
//
//  Created by Ivailo Abadjiev on 29.08.19.
//  Copyright © 2019 Ivailo Abadjiev. All rights reserved.
//

import UIKit
import RadarSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, RadarDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Radar.initialize(publishableKey: "")
        Radar.setDelegate(self)

        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager(locationManager, didChangeAuthorization: CLLocationManager.authorizationStatus())
        }

        // Override point for customization after application launch.
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            Radar.stopTracking()
            locationManager.stopUpdatingLocation()
        case .authorizedWhenInUse:
            fatalError("we do not want to handle it in this project")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            Radar.startTracking()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("did fail with error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("did update locations: \(locations)")
    }

    func didReceiveEvents(_ events: [RadarEvent], user: RadarUser) {
        print("did receive events: \(events)")
    }
    
    func didUpdateLocation(_ location: CLLocation, user: RadarUser) {
        print("did update location: \(location)")
    }
    
    func didFail(status: RadarStatus) {
        print("did fail with status: \(status)")
    }
    
    func didUpdateClientLocation(_ location: CLLocation, stopped: Bool) {
        print("did update client location: \(location) stopped: \(stopped)")
    }
}

