//
//  OrderConfirmationViewController.swift
//  RESTaurant App
//
//  Created by Noud on 5-12-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    var minutes: Int!
    
    // MARK: updates the text of the pop-up according to the given time
    override func viewDidLoad() {
        super.viewDidLoad()
        timeRemainingLabel.text = "Thank you for your order! Your wait time is approximately \(minutes!) minutes."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
