//
//  EvenSchoolCell.swift
//  University
//
//  Created by Melinda Diaz on 1/2/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit


class EvenSchoolCell: UITableViewCell {
    
    @IBOutlet weak var nameLabelOutlet: UILabel!
    @IBOutlet weak var countryLabelOutlet: UILabel!
    @IBOutlet weak var alphaTwoLabel: UILabel!
    @IBOutlet weak var websiteOutlet: UILabel!
    
    
    func setUpDetails(eachCell: Universities) {
        nameLabelOutlet.text = eachCell.name
        countryLabelOutlet.text = "Country \(eachCell.country)"
        alphaTwoLabel.text = eachCell.alphaTwoCode
        //why this is an optional???
        websiteOutlet.text = eachCell.webPages.description
    }
   
}


