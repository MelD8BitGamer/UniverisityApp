//
//  ViewController.swift
//  University
//
//  Created by Melinda Diaz on 1/2/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var schoolTableView: UITableView!
    var allUniversities = [[Universities]]() {
        didSet{
            DispatchQueue.main.async {
                self.schoolTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schoolTableView.dataSource = self
        schoolTableView.delegate = self
        setUp()
        navigationItem.title = "Universities Around The World"
    }
    
    
    
    func setUp() {
        APIClient.getSchools(for: "http://universities.hipolabs.com/search") { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Cannot Load Universities\(appError)")
                }
            case .success(let data):
                //because data is only an array of Unis then you have to convert it to a matrix. therefore you need to call the static function  and approach it as so
                let matrix = Universities.getSection(data)
                self?.allUniversities = matrix
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = schoolTableView.indexPathForSelectedRow,
            let detailedVC = segue.destination as? DetailedViewController else {
                fatalError("Could not segue")}
        let eachCell = allUniversities[indexPath.section][indexPath.row]
        detailedVC.universityRef = eachCell
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allUniversities[section].first?.country // in order to access the element needed in the matrix you can use double indexing(this is not the real technical term) as done above
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allUniversities.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUniversities[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as? SchoolCell else { fatalError("could not load data")}
        cell.countryLabel.text = allUniversities[indexPath.section][indexPath.row].country
        cell.nameLabel.text = allUniversities[indexPath.section][indexPath.row].name
        //cell.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1).cgColor
        //to make each cell a different color
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
