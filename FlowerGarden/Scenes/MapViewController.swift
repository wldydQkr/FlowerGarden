
//
//  ViewController.swift
//  FlowerGarden
//
//  Created by kdw on 2022/09/13.
//  test
import UIKit
import NMapsMap
import CoreLocation
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var ownerStoreName: UILabel!
    @IBOutlet weak var ownerAddress: UILabel!
    @IBOutlet weak var ownerStoreNumber: UILabel!
    var locationManager = CLLocationManager()
    let redView = UIView()
    var marker = NMFMarker()
    var markers: [NMFMarker] = []
    var ownerList: [Owners] = []
    var ownerSave = Owners()
    let jsonDecoder: JSONDecoder = JSONDecoder()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: UITapGestureRecognizer - ownerLabel tap
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        ownerStoreName.addGestureRecognizer(tapGestureRecognizer)
        ownerStoreName.isUserInteractionEnabled = true
        
        let mapView = NMFMapView(frame: view.frame)
        mapView.touchDelegate = self
        view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            
            //현 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            

            dbLoad { owner in
                
                self.ownerList = owner
                
                DispatchQueue.global(qos: .default).async { [self] in
                    // 백그라운드 스레드
                    for index in 0..<owner.count {

                        self.marker = {
                            var marker = NMFMarker()
                            marker.position = NMGLatLng(lat: Double(owner[index].y) ?? 0, lng: Double(owner[index].x) ?? 0)
                            
                            marker = NMFMarker(position: marker.position)
                            
                            marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                                
                                self.ownerStoreName.text = owner[index].store_name
                                self.ownerAddress.text = owner[index].store_address
                                self.ownerStoreNumber.text = owner[index].store_number
                                
                                self.ownerSave = owner[index]
                                
                                self.subView?.isHidden = false
                                self.view.bringSubviewToFront(self.subView!)
                                
                                return true
                            }
                                
                            marker.iconImage = NMFOverlayImage(name: "marker_image_default")
                            marker.width = 50
                            marker.height = 50
                            
                            return marker
                        }()
                        
                        markers.append(self.marker)
                        
                    }
                    
                    DispatchQueue.main.async {
                        // 메인 스레드
                        for marker in self.markers {
                            marker.mapView = mapView
                        }
                    }
                    

                }
                
            }

        } else {
            print("위치 서비스 Off 상태")
        }
    }
    
}

// MARK: - 지도 탭 델리게이트
extension MapViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        
        self.marker.width = 50
        self.marker.height = 50
        self.marker.iconImage = NMFOverlayImage(name: "marker_image_default")
        self.subView?.isHidden = true
        
        print("지도 탭")
    }
}

extension MapViewController {
    
    func dbLoad(completion: @escaping ([Owners]) -> Void) {
        // MARK: - firebase 데이터베이스 파싱
        let db = Database.database().reference()
        db.child("owner_list").observeSingleEvent(of: .value){ snapshot,uid  in
            guard let snapData = snapshot.value as? [String:Any] else {return}
            //Data를 JSON형태로 변경해줍니다.
            let data = try! JSONSerialization.data(withJSONObject: Array(snapData.values), options: [])
            do{
                self.ownerList = try JSONDecoder().decode([Owners].self, from: data)
                
                completion(self.ownerList)
                
            }catch let error {
                print("\(error.localizedDescription)")
            }
        }
        
    }
    
    // MARK: UITapGestureRecognizer - ownerLabel tap
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        
        print("ownerSave:", ownerSave)
        
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeDetailViewController") as? HomeDetailViewController else {return}
        
        performSegue(withIdentifier: "detailViewIdentifier", sender: nil)
        
//        self.present(detailVC, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailViewIdentifier" {
            
            guard let destination = segue.destination as? HomeDetailViewController else {
                return
            }
            
            destination.savedOwner = ownerSave
            
        } else {
            print("error!!")
        }
    }
    
}
