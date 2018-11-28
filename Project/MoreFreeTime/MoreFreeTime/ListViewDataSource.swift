//
//  ListViewDataSource.swift
//  MoreFreeTime
//
//  Created by Dylan Zeller on 11/26/18.
//  Copyright © 2018 Dylan Zeller. All rights reserved.
//

import Foundation
import UIKit

class ListViewDatasource: NSObject, UITableViewDataSource {
    var list = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
}
