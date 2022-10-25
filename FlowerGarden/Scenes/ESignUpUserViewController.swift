//
//  ESignUpUserViewController.swift
//  FlowerGarden
//
//  Created by 심두용 on 2022/09/27.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ESignUpUserViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completionButton.layer.cornerRadius = 5
    }

    @IBAction func completionButtonTapped(_ sender: Any) {
         //신규 사용자 생성
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") {[weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정일 때
                    //self.loginUser(withEamil: email, password: password)
                    self.errorMessageLabel.text = error.localizedDescription
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                // 회원가입하면 자동으로 로그인 -> 로그인된 uid 추출
                let user = Auth.auth().currentUser
                // Real Database에 회원 저장
                var ref: DatabaseReference!
                ref = Database.database().reference()
                ref.child("user_list").child(user?.uid ?? "uid")
                    .setValue(["uid": user?.uid,
                               "name": self.nameTextField.text,
                               "email": self.emailTextField.text])
                self.showLoginViewController()
            }
        }
    }
    private func showLoginViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "EmailLogin")
        vc.modalPresentationStyle = .fullScreen
        navigationController?.show(vc, sender: nil)
    }
    
}
