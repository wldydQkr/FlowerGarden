//
//  ViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//
import UIKit
import NMapsMap
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // test
        let mapView = NMFMapView(frame: view.frame)
        let naverMapView = NMFNaverMapView()
        view.addSubview(mapView)
        
        naverMapView.showCompass = true
        naverMapView.showLocationButton = true
        naverMapView.positionMode = .direction
        mapView.positionMode = .normal

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)

            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)

            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = mapView
        } else {
            print("위치 서비스 Off 상태")
        }

        // ------------------------------마커 여러개 찍기 -----------------------------------------
//        DispatchQueue.global(qos: .default).async { [self] in
//            // 백그라운드 스레드
//            var markers = [NMFMarker]()
//            for index in 1...10 {
//                var i = Double(index) * 0.01
//                let marker = NMFMarker(position: NMGLatLng(lat: (self.locationManager.location?.coordinate.latitude)! + i ?? 0 , lng: locationManager.location?.coordinate.longitude ?? 0))
////                marker.iconImage = ...
////                marker.captionText = ...
//                markers.append(marker)
//            }
//
//            DispatchQueue.main.async {
//                // 메인 스레드
//                for marker in markers {
//                    marker.mapView = mapView
//                }
//
//            }
//        }
        // ------------------------------마커 여러개 찍기 -----------------------------------------

        
        
    }
    
}

