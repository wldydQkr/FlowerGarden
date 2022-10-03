//
//  SignUpOwnerViewController.swift
//  FlowerGarden
//
//  Created by 심두용 on 2022/09/25.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class GSignUpOwnerViewController: UIViewController {

    @IBOutlet weak var storeNameTextField: UITextField!
    @IBOutlet weak var storeAddressTextField: UITextField!
    @IBOutlet weak var completionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        completionButton.layer.cornerRadius = 8
    }
    
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        
        // 구글 회원 정보 불러오기
        if let userInfo = Auth.auth().currentUser?.providerData[0] {
            let user = Auth.auth().currentUser
            
            // Real Database에 회원 저장
            var ref: DatabaseReference!
            ref = Database.database().reference()
            ref.child("owner_list").child(user?.uid ?? "uid").setValue(["uid": user?.uid, "name": userInfo.displayName, "email": userInfo.email, "store_name": storeNameTextField.text, "store_address": storeAddressTextField.text])
        }
        // 메인 화면으로 이동
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigationController")
        vc.modalPresentationStyle = .fullScreen
        //UIApplication.shared.windows.first?.rootViewController?.show(mainViewController, sender: nil)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController?.show(vc, sender: nil)
    }
    
}
