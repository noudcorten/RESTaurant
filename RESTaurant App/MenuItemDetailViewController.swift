//
//  MenuItemDetailViewController.swift
//  RESTaurant App
//
//  Created by Noud on 5-12-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToOrderButton: UIButton!
    
    var menuItem: MenuItem!
    var delegate: AddToOrderDelegate?
    
    // MARK: updates the UI according to the selected menuItem
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        setUpDelegate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: updates the information of the selected menuItem (e.g. title, description, price, etc.)
    func updateUI() {
        titleLabel.text = menuItem.name
        descriptionLabel.text = menuItem.description
        priceLabel.text = String(format: "$%.2f", menuItem.price)
        addToOrderButton.layer.cornerRadius = 5.0
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    // MARK: a delegate is used to udpate the OrderList when something is added to the order
    func setUpDelegate() {
        if let navController = tabBarController?.viewControllers?.last as? UINavigationController,
            let orderTableViewController = navController.viewControllers.first as? OrderTableViewController {
            delegate = orderTableViewController
        }
    }

    // MARK: when something is added to the order the OrderList is updated and the chosen menuItem is added to the OrderList
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) { 
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        delegate?.added(menuItem: menuItem)
    }
}
