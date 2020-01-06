//
//  SearchViewController.swift
//  University
//
//  Created by Melinda Diaz on 1/2/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchSchoolBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var allSchools = [Universities](){
        didSet {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    var userQuery = "" {
        didSet {
            APIClient.getSchools(for: "http://universities.hipolabs.com/search?name=") { [weak self] (result) in
                switch result {
                case .failure(let appError):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Data Failure", message: "Unable to retrieve Universities \(appError)")
                    }
                case .success(let data):
                    self?.allSchools = data.filter{$0.name.lowercased().contains(self!.userQuery.lowercased()) }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchSchoolBar.delegate = self
        searchTableView.dataSource = self
        searchTableView.delegate = self
        navigationItem.title = "Search Universities by Name"
        setUpSearch()
    }
    func setUpSearch() {
        allSchools = [Universities]()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = searchTableView.indexPathForSelectedRow,
            let detailedVC = segue.destination as? DetailedViewController else {
                fatalError("could not segue")}
        let eachCell = allSchools[indexPath.row]
        detailedVC.universityRef = eachCell
        
    }
}


extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "evenSchoolCell", for: indexPath) as? EvenSchoolCell else { fatalError("could not load cell")}
        
        cell.setUpDetails(eachCell: allSchools[indexPath.row])
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    //TODO: fix this search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        userQuery = searchText
    }
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension SearchViewController: SFSafariViewControllerDelegate {
    
}
