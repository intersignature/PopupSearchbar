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
        
        searchbarView.delegate = self
        searchbarView.searchIcon = UIImageView(image: UIImage(named: "icons16PxSearch"))
        searchbarView.needTapView = false
        
        searchbarView.models = [SearchModel(id: 1, value: "a"), SearchModel(id: 2, value: "b"), SearchModel(id: 3, value: "c"), SearchModel(id: 4, value: "d"), SearchModel(id: 5, value: "e"), SearchModel(id: 6, value: "f"), SearchModel(id: 7, value: "g")]
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.searchbarView.models = [SearchModel(id: 1, value: "a"), SearchModel(id: 2, value: "b")]
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension ViewController: SearchbarDelegate {
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        searchbarView.endEditing(true)
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
    }
    
    func headerDidTapAtTapView() {
    }
    
    func headerDidTapCloseView() {
    }
    
    func didClearAllHistory() {
    }
    
    func didSelectAt(model: SearchModel) {
    }
}
