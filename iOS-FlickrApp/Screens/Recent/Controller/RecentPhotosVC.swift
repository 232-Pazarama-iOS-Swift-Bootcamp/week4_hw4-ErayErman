//
//  RecentPhotosVC.swift
//  iOS-FlickrApp
//
//  Created by Eray on 17.10.2022.
//

import UIKit
import AlamofireImage


class RecentPhotosVC: CAViewController {

    @IBOutlet var tableView: UITableView!
    private var viewModel : RecentPhotosVM

    
    // MARK: - Init
        init(viewModel: RecentPhotosVM ) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.hidesBackButton = true
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "mainTableCell")
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.fetchPhotos()
        
        viewModel.changeHandler = { change in
            switch change {
            case .didFetchRecentPhotos:
                self.tableView.reloadData()
            case .didErrorOccurred(let error):
                self.showError(error)
            }
        }
    }

}

// MARK: - UITableViewDelegate
 extension RecentPhotosVC : UITableViewDelegate {
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

     }
     
 }

// MARK: - UITableViewDataSouce

extension RecentPhotosVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // mainTableCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableCell", for: indexPath) as! TableViewCell
        let photo = viewModel.photoForIndexPath(indexPath)
        cell.username.text = photo?.ownername
        let urlString: String = photo?.urlC ?? "https://live.staticflickr.com/65535/52439244120_eb00d487fd_c.jpg"
        let url = URL(string: urlString)!
        cell.photoNew?.af.setImage(withURL: url, completion: { _ in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        })
        return cell
    }
    
    
}

