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
    func textFieldShouldReturn(_ textField: UITextField)
    func headerDidTapAtTapView()
    func headerDidTapCloseView()
    func didClearAllHistory()
    func didSelectAt(model: SearchModel)
}

class SearchbarView: UIControl {
    
    var height: CGFloat = 0.0
    
    lazy var headerView: SearchbarHeaderView = {
        let h = SearchbarHeaderView(frame: .zero)
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    lazy var resultView: SearchbarResultView = {
        let r = SearchbarResultView(frame: .zero)
        r.translatesAutoresizingMaskIntoConstraints = false
        r.isHidden = true
        return r
    }()
    
    var delegate: SearchbarDelegate?
    
    var models: [SearchModel] = [] {
        didSet {
            resultView.models = models
        }
    }
    
    var endEditing: Bool = true {
        didSet {
            headerView.textField.endEditing(endEditing)
        }
    }
    
    var searchIcon: UIImageView? = nil {
        didSet {
            if let searchIcon = searchIcon, let searchImage = searchIcon.image {
                headerView.imageView.image = searchImage
                headerView.imageView.isHidden = false
            } else {
                headerView.imageView.image = nil
                headerView.imageView.isHidden = true
            }
        }
    }
    
    var needTapView: Bool = false {
        didSet {
            headerView.needTapView = needTapView
        }
    }
    
    var tapViewColor: UIColor = .yellow {
        didSet {
            headerView.tapView.backgroundColor = tapViewColor
        }
    }
    
    var tapViewOpacity: Float = 1.0 {
        didSet {
            headerView.tapView.layer.opacity = tapViewOpacity
        }
    }
    
    var headerBackgroundColor: UIColor = .white {
        didSet {
            headerView.backgroundColor = headerBackgroundColor
        }
    }
    
    var closeIcon: UIImageView? = nil {
        didSet {
            if let closeIcon = closeIcon, let closeImage = closeIcon.image {
                headerView.closeImageView.image = closeImage
            } else {
                headerView.closeImageView.image = UIImage(named: "icons16PxRemoveRound")
            }
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let constraint = (self.constraints.filter{$0.firstAttribute == .height}.first) {
            if height == headerView.bounds.size.height + resultView.bounds.size.height { return }
            constraint.constant = headerView.bounds.size.height + resultView.bounds.size.height
            self.height = headerView.bounds.size.height + resultView.bounds.size.height
        } else {
            self.heightAnchor.constraint(equalToConstant: headerView.bounds.size.height + resultView.bounds.size.height).isActive = true
            height = headerView.bounds.size.height + resultView.bounds.size.height
        }
    }
    
    func shareInitialization() {
        
        clipsToBounds = false
        
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
        resultView.isHidden = false
        delegate?.textFieldDidBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resultView.isHidden = true
        delegate?.textFieldDidEndEditing(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
        delegate?.textFieldShouldReturn(textField)
    }
    
    func headerDidTapAtTapView() {
        delegate?.headerDidTapAtTapView()
    }
    
    func headerDidTapCloseView() {
        resultView.isHidden = true
        endEditing(true)
        delegate?.headerDidTapCloseView()
    }
}

extension SearchbarView: SearchbarResultDelegate {
    func didClearAllHistory() {
        resultView.isHidden = true
        delegate?.didClearAllHistory()
    }
    
    func didSelectAt(model: SearchModel) {
        resultView.isHidden = true
        delegate?.didSelectAt(model: model)
    }
}
