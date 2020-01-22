//
//  SearchbarView.swift
//  BaseUI
//
//  Created by Sirichai Binchai on 22/1/2563 BE.
//  Copyright © 2563 Sirichai Binchai. All rights reserved.
//

import UIKit

protocol SearchbarDelegate {
    func textFieldDidChange(_ textField: UITextField)
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
    func headerDidTapAtTapView()
    func headerDidTapCloseView()
    func didClearAllHistory()
    func didSelectAt(model: SearchModel)
}

class SearchbarView: UIControl {
    
    lazy var headerView: SearchbarHeaderView = {
        let h = SearchbarHeaderView(frame: .zero)
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var resultView: SearchbarResultView = {
        let r = SearchbarResultView(frame: .zero)
        r.translatesAutoresizingMaskIntoConstraints = false
        return r
    }()
    
    var delegate: SearchbarDelegate?
    
    var models: [SearchModel] = [] {
        didSet {
            resultView.models = models
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shareInitialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        shareInitialization()
    }
    
    func shareInitialization() {
        
        headerView.delegate = self
        resultView.delegate = self
        
        addSubview(headerView)
        addSubview(resultView)
        
        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        resultView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8).isActive = true
        resultView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        resultView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        resultView.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        resultView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
    }
}

extension SearchbarView: SearchbarHeaderDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func headerDidTapAtTapView() {
        delegate?.headerDidTapAtTapView()
    }
    
    func headerDidTapCloseView() {
        delegate?.headerDidTapCloseView()
    }
}

extension SearchbarView: SearchbarResultDelegate {
    func didClearAllHistory() {
        delegate?.didClearAllHistory()
    }
    
    func didSelectAt(model: SearchModel) {
        delegate?.didSelectAt(model: model)
    }
}
