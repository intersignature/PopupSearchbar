//
//  ViewController.swift
//  PopupSearchbar
//
//  Created by Sirichai Binchai on 22/1/2563 BE.
//  Copyright © 2563 Sirichai Binchai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchbarView: SearchbarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchbarView.models = [SearchModel(id: 1, value: "a"), SearchModel(id: 2, value: "b"), SearchModel(id: 3, value: "c"), SearchModel(id: 4, value: "d"), SearchModel(id: 5, value: "e"), SearchModel(id: 6, value: "f"), SearchModel(id: 7, value: "g")]
    }


}

