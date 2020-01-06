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
    @IBOutlet weak var universityWebsite: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDetail()
        
    }
    
    func setUpDetail() {
        universityName.text = universityRef?.name
        universityCountry.text = "Country:\(universityRef?.country ?? "NA")" 
        universityState.text = "State/Province"
        universityWebsite.text = universityRef?.webPages.description
    
    }
    
    
}

extension DetailedViewController: SFSafariViewControllerDelegate {
 
}
