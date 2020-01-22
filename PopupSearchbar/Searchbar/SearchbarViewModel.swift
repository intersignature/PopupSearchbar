//
//  SearchbarViewModel.swift
//  BaseUI
//
//  Created by Sirichai Binchai on 22/1/2563 BE.
//  Copyright © 2563 Sirichai Binchai. All rights reserved.
//

import Foundation
import UIKit

class ResultSearchbarViewModel {
    
    var datasource: ResultSearchbarDatasource?
    
    init() {
        datasource = ResultSearchbarDatasource()
    }
}

class ResultSearchbarDatasource: NSObject, UITableViewDataSource {
    
    var models: [SearchModel] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = UITableViewCell()
        cell.backgroundColor = .green
        cell.textLabel?.text = model.value
        return cell
    }
}
