//
//  SearchVC.swift
//  iOS-FlickrApp
//
//  Created by Eray on 18.10.2022.
//

import UIKit

class SearchVC: CAViewController, UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel : SearchVM
    private var initialViewModel : RecentPhotosVM

    
     // MARK: - Init
    init(viewModel: SearchVM, initialViewModel: RecentPhotosVM ) {
        self.viewModel = viewModel
        self.initialViewModel = initialViewModel
        super.init(nibName: nil, bundle: nil)
        
         }
         
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
     
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.navigationItem.hidesBackButton = true
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.searchBar.delegate = self
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchSearchPhotos:
                self.collectionView.reloadData()
            case .didErrorOccurred(let error):
                self.showError(error)
            }
        }
    }
       
    }



 extension SearchVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating
{
     func updateSearchResults(for searchController: UISearchController) {
         if let text = searchController.searchBar.text, text.count > 1 {
             viewModel.fetchSearch(with: text)
             
         }

     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 30
         
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
         
         let data = initialViewModel.photoForIndexPath(indexPath)
         let urlString: String = data?.urlC ?? "https://live.staticflickr.com/65535/52439244120_eb00d487fd_c.jpg"
         let url = URL(string: urlString)!
         cell.imageView.af.setImage(withURL: url)
         return cell
     }
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
         let width = self.view.frame.width/3
         let height = self.view.frame.width/3
            
            return CGSize(width: width, height: height)
        }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         collectionView.deselectItem(at: indexPath, animated: true)

     }
     
     
 }

