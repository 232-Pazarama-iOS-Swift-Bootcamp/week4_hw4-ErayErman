//
//  AuthViewController.swift
//  iOS-FlickrApp
//
//  Created by Eray on 15.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseRemoteConfig

final class AuthViewController: CAViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var credentionTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let viewModel: AuthViewModel

    enum AuthType: String {
        case signIn = "Sign In"
        case signUp = "Sign Up"
        
        init(text: String) {
            switch text {
            case "Sign In":
                self = .signIn
            case "Sign Up":
                self = .signUp
            default:
                self = .signIn
            }
        }
    }
    
    var authType: AuthType = .signIn {
        didSet {
            let segmentTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
            titleLabel.text = segmentTitle
            confirmButton.setTitle(segmentTitle, for: .normal)
        }
    }
    
 
    
    // MARK: - Init
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        title = "Auth"
        
        viewModel.changeHandler = { change in
            switch change {
            case .didErrorOccurred(let error):
                self.showError(error)
            case .didSignUpSuccessful:
                self.showAlert(title: "SIGN UP SUCCESSFUL!")
            }
        }
        /*
        flickrApiProvider.request(.getRecentPhotos) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                print(String(decoding: response.data, as: UTF8.self))
            }
        }
        */
       
    }
    
    @IBAction private func didTapLoginButton(_ sender: UIButton) {
        guard let credential = credentionTextField.text,
              let password = passwordTextField.text else {
            return
        }
        switch authType {
        case .signIn:
            viewModel.signIn(email: credential,
                             password: password,
                             completion: { [weak self] in
                guard let self = self else { return }
                
                 let recentPhotoViewModel = RecentPhotosVM()
                 let recentPhotosViewController = RecentPhotosVC(viewModel: recentPhotoViewModel)
                
                recentPhotosViewController.title = "Recents"

                recentPhotosViewController.tabBarItem.image = UIImage(named: "house")
                recentPhotosViewController.tabBarItem.selectedImage = UIImage(named: "house_fill")

                
                let searchViewModel = SearchVM()
                let searchViewController = SearchVC(viewModel: searchViewModel, initialViewModel: recentPhotoViewModel)
                searchViewController.title = "Search"
                searchViewController.tabBarItem.image = UIImage(named: "Magnifyingglass Circle")
                searchViewController.tabBarItem.selectedImage = UIImage(named: "Magnifyingglass Circle_Fill")
                
                let profileViewModel = ProfileVM()
                let profileViewController = ProfileVC(viewModel: profileViewModel)
                profileViewController.title = "Profile"
                profileViewController.tabBarItem.image = UIImage(named: "PersonCropSquare")
                profileViewController.tabBarItem.selectedImage = UIImage(named: "PersonCropSquare_Fill")
                
                 let tabBarController = UITabBarController()
                 tabBarController.viewControllers = [recentPhotosViewController, searchViewController, profileViewController]
                 self.navigationController?.pushViewController(tabBarController, animated: true)
                 
                 
             
            })
        case .signUp:
            viewModel.signUp(email: credential,
                             password: password)
        }
    }
    
    @IBAction private func didValueChangedSegmentedControl(_ sender: UISegmentedControl) {
        let segmentTitle = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        authType = AuthType(text: segmentTitle ?? "Sign In")
    }
}
