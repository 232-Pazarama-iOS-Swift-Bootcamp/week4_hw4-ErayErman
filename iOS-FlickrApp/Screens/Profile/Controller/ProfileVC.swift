//
//  ProfileVC.swift
//  iOS-FlickrApp
//
//  Created by Eray on 18.10.2022.
//

import UIKit
import AlamofireImage

class ProfileVC: CAViewController {

    
    @IBOutlet var username: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel : ProfileVM
    @IBOutlet var signOutButton: UIButton!
    
    init(viewModel: ProfileVM ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        tabBarController?.navigationItem.hidesBackButton = true
        setupUI()
        
     
       
    }
    private func setupUI() {
        let nib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        viewModel.fetchPhotos()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchRecentPhotos:
                self.collectionView.reloadData()
            case .didErrorOccurred(let error):
                self.showError(error)
            }
        }
       
    }
   
    @IBAction func didClickedSignOutButton(_ sender: Any) {
        let authViewModel = AuthViewModel()
        let autViewController = AuthViewController(viewModel: authViewModel)
        self.navigationController?.pushViewController(autViewController, animated: true)
    }
    
}
// MARK: - CollectionViewCe

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        let photo = viewModel.photoForIndexPath(indexPath)
        let urlString: String = photo?.urlC ?? "https://live.staticflickr.com/65535/52439244120_eb00d487fd_c.jpg"
        let url = URL(string: urlString)!
        cell.imageView.af.setImage(withURL: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - gridLayout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:100)
    }
}
