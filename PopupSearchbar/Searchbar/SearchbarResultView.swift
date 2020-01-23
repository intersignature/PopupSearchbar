//
//  SearchbarResultView.swift
//  BaseUI
//
//  Created by Sirichai Binchai on 22/1/2563 BE.
//  Copyright © 2563 Sirichai Binchai. All rights reserved.
//

import UIKit

struct SearchModel {
    let id: Int!
    let value: String!
}

protocol SearchbarResultDelegate {
    func didClearAllHistory()
    func didSelectAt(model: SearchModel)
}

class SearchbarResultView: UIControl {
    
    var selectedRow: Int = 0
    var oldCount: Int = 0
    var rowHeight: CGFloat = 42.5
    var delegate: SearchbarResultDelegate?
    var viewModel = ResultSearchbarViewModel()
    
    var count: Int = 0 {
        didSet {
            _ = configTableViewRect(count: count)
        }
    }
    
    var models: [SearchModel] = [] {
        didSet {
            viewModel.datasource?.models = models
            count = models.count
            tableView.reloadData()
        }
    }
    
    lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.spacing = 5
        s.alignment = .fill
        s.distribution = .fill
        s.axis = .vertical
        return s
    }()
    
    lazy var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.text = "title"
        l.backgroundColor = .lightGray
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .systemFont(ofSize: 22)
        l.textColor = .darkGray
        return l
    }()
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: .zero)
        t.isScrollEnabled = false
        t.translatesAutoresizingMaskIntoConstraints = false
        
        let v = UIView()
        v.backgroundColor = .lightGray
        
        t.backgroundColor = .lightGray
        t.backgroundView = v
        return t
    }()
    
    lazy var footerLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.isUserInteractionEnabled = true
        l.font = .boldSystemFont(ofSize: 18)
        l.textColor = .darkGray
        l.text = "text"
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        shareInitialization()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        shareInitialization()
    }
    
    func shareInitialization() {
        
        let clearHistory: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleClearHistory(_:)))
        footerLabel.addGestureRecognizer(clearHistory)
        
        clipsToBounds = false
        layer.cornerRadius = 10
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(footerLabel)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = viewModel.datasource
    }
    
    func configTableViewRect(count: Int) -> CGSize {
        if count == 0 {
            isHidden = true
        }
        NSLayoutConstraint.deactivate(tableView.constraints)
        tableView.heightAnchor.constraint(equalToConstant: CGFloat.minimum((rowHeight * CGFloat(count))+40, UIScreen.main.bounds.size.height)).isActive = true
        oldCount = count
        if count == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: rowHeight)
        } else {
            return CGSize(width: UIScreen.main.bounds.size.width, height: CGFloat.minimum((rowHeight * CGFloat(count))+40, UIScreen.main.bounds.size.height))
        }
    }
    
    @objc func handleClearHistory(_ sender: UITapGestureRecognizer) {
        delegate?.didClearAllHistory()
        isHidden = true
    }
}

extension SearchbarResultView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectAt(model: (viewModel.datasource?.models[indexPath.row])!)
    }
}
