//
//  KaokaoZipCodeVC.swift
//  testapp
//
//  Created by 김두원 on 2022/09/25.
//

import UIKit
import WebKit

class KakaoZipCodeVC: UIViewController {

    // MARK: - Properties
    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var delegate: ZipcodeDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }

    // MARK: - UI
    private func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }

    private func setAttributes() {
        // WKUserContentController: javascript를 읽을 수 있게 도와주는 '클래스 + add(_:name:)'
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        self.webView?.navigationDelegate = self

        guard let url = URL(string: "https://dw0124.github.io/Kakao-PostCode/"),
            let webView = webView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }

    private func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            indicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor),
        ])
    }
}

extension KakaoZipCodeVC: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
//            print(address)
        }
        getData(qValue: address){ responseData in
            
            self.delegate?.sendZipcode(data:responseData)
            
        }
        // MARK: dissmiss
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension KakaoZipCodeVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}

// MARK: - getData(qValue:) x,y 좌표 추출 api
extension KakaoZipCodeVC {
    
    func getData(qValue: String, completion: @escaping (Addresses) -> Void){
        
        var components = URLComponents(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode")
        let q = URLQueryItem(name: "query", value: qValue)
        components?.queryItems = [q]
        
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        
        // 헤더 추가
        request.allHTTPHeaderFields = [ "X-NCP-APIGW-API-KEY-ID":"oawdp0aaj8"
                                        ,"X-NCP-APIGW-API-KEY":"57izDE8XXK6gVEP5kLUL28zt3zx82dgr2VpzFAGL" ]
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
//            print(data)
            
            do{
                let result = try JSONDecoder().decode(Addresses.self, from: data)
                print(result.addresses[0].x)
                completion(result)
            } catch {
                print(error)
            }
        }
        
        dataTask.resume()
        
    }
}



//
////
////  ViewController.swift
////  FlowerGarden
////
////  Created by 박지용 on 2022/09/13.
////  test
//import UIKit
//import NMapsMap
//import CoreLocation
//
//class MapViewController: UIViewController, CLLocationManagerDelegate {
//
//    var locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        // test
//        let mapView = NMFMapView(frame: view.frame)
//        let naverMapView = NMFNaverMapView()
//        view.addSubview(mapView)
//
//        naverMapView.showCompass = true
//        naverMapView.showLocationButton = true
//        naverMapView.positionMode = .direction
//        mapView.positionMode = .normal
//
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//
//        if CLLocationManager.locationServicesEnabled() {
//            print("위치 서비스 On 상태")
//            locationManager.startUpdatingLocation()
//            print(locationManager.location?.coordinate)
//
//            //현 위치로 카메라 이동
//            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
//            cameraUpdate.animation = .easeIn
//            mapView.moveCamera(cameraUpdate)
//
//            let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
//            marker.mapView = mapView
//        } else {
//            print("위치 서비스 Off 상태")
//        }
//
//        // ------------------------------마커 여러개 찍기 -----------------------------------------
////        DispatchQueue.global(qos: .default).async { [self] in
////            // 백그라운드 스레드
////            var markers = [NMFMarker]()
////            for index in 1...10 {
////                var i = Double(index) * 0.01
////                let marker = NMFMarker(position: NMGLatLng(lat: (self.locationManager.location?.coordinate.latitude)! + i ?? 0 , lng: locationManager.location?.coordinate.longitude ?? 0))
//////                marker.iconImage = ...
//////                marker.captionText = ...
////                markers.append(marker)
////            }
////
////            DispatchQueue.main.async {
////                // 메인 스레드
////                for marker in markers {
////                    marker.mapView = mapView
////                }
////
////            }
////        }
//        // ------------------------------마커 여러개 찍기 -----------------------------------------
//
//
//
//    }
//
//}

//
