//
//  AddToOrderDelegate.swift
//  RESTaurant App
//
//  Created by Noud on 5-12-18.
//  Copyright © 2018 Noud. All rights reserved.
//

import Foundation

// MARK: used to update the TabBar if the user adds a menuItem
protocol AddToOrderDelegate {
    func added(menuItem: MenuItem)
}
