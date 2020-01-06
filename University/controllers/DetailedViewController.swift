//
//  DetailedViewController.swift
//  University
//
//  Created by Melinda Diaz on 1/6/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
import SafariServices

class DetailedViewController: UIViewController {
    //TODO: Make this work with detailed view instead
    
    var universityRef: Universities?
    
    @IBOutlet weak var universityName: UILabel!
    @IBOutlet weak var universityCountry: UILabel!
    @IBOutlet weak var universityState: UILabel!
    @IBOutlet weak var universityDomain: UILabel!
    @IBOutlet weak var websiteButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetail()
        
    }
    
    @IBAction func websiteButton(_ sender: UIButton) {
        guard let string = universityRef?.webPages.first,
            let url = URL(string: string) else {
                showAlert(title: "Error", message: "Could not turn into URL")
                return
        }
        let instance = SFSafariViewController(url: url)
        instance.delegate = self
        present(instance, animated: true)
    }
    
    func setUpDetail() {
        universityName.text = universityRef?.name
        universityCountry.text = "Country: \(universityRef?.country ?? "NA")" 
        universityState.text = "State/Province: \(universityRef?.stateProvince ?? "NA")"
        websiteButtonOutlet.setTitle(universityRef?.webPages.first, for: .normal)
    }
    
    
}



extension DetailedViewController: SFSafariViewControllerDelegate {
    
}
