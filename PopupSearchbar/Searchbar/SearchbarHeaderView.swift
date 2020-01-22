//
//  SearchbarHeaderView.swift
//  BaseUI
//
//  Created by Sirichai Binchai on 22/1/2563 BE.
//  Copyright © 2563 Sirichai Binchai. All rights reserved.
//

import UIKit

protocol SearchbarHeaderDelegate {
    func textFieldDidChange(_ textField: UITextField)
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
    func headerDidTapAtTapView()
    func headerDidTapCloseView()
}

class SearchbarHeaderView: UIControl {
    
    var delegate: SearchbarHeaderDelegate?
    
    @IBInspectable
    var isActive: Bool = false {
        didSet {
            if isActive {
                self.closeImageView.isHidden = false
                self.layer.borderWidth = 1
            } else {
                self.closeImageView.isHidden = true
                self.layer.borderWidth = 0
            }
        }
    }
    
    @IBInspectable
    var text: String? {
        set {
            textField.text = newValue
        } get {
            return textField.text
        }
    }
    
    @IBInspectable
    var placeHolder: String = "" {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    
    @IBInspectable
    var needTapView: Bool = true {
        didSet {
            tapView.isHidden = !needTapView
        }
    }
    
    lazy var stackView: UIStackView = {
        let s = UIStackView(frame: CGRect.zero)
        s.backgroundColor = .clear
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.distribution = .fill
        s.alignment = .fill
        s.spacing = 8
        return s
    }()
    
    lazy var imageView: UIImageView = {
        let i = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        i.image = UIImage(named: "icons16PxSearch")
        i.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    lazy var textField: UITextField = {
        let t = UITextField(frame: CGRect.zero)
        t.borderStyle = .none
        t.translatesAutoresizingMaskIntoConstraints = false
        t.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        t.placeholder = "placeHolder"
        t.textColor = .red
        t.font = .systemFont(ofSize: 16)
        return t
    }()
    
    lazy var closeImageView: UIImageView = {
        let i = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        i.isUserInteractionEnabled = true
        i.image = UIImage(named: "icons16PxRemoveRound")
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.isHidden = true
        return i
    }()
    
    lazy var tapView: UIView = {
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
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
        
        addTapGesture()
        addTapViewGesture()
        addCloseGesture()
        
        clipsToBounds = false
        
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        addSubview(stackView)
        addSubview(tapView)
        bringSubviewToFront(tapView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(closeImageView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        tapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tapView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tapView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 0
        
        layer.cornerRadius = 10
    }
    
    func addTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    func addTapViewGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapInTapView(_:)))
        tapView.addGestureRecognizer(tapGesture)
    }
    
    func addCloseGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleClose(_:)))
        closeImageView.addGestureRecognizer(tapGesture)
    }
}

extension SearchbarHeaderView: UITextFieldDelegate {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        sendActions(for: .touchUpInside)
    }
    
    @objc func handleTapInTapView(_ sender: UITapGestureRecognizer) {
        delegate?.headerDidTapAtTapView()
    }
    
    @objc func handleClose(_ sender: UITapGestureRecognizer) {
        delegate?.headerDidTapCloseView()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        delegate?.textFieldDidChange(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isActive = true
        delegate?.textFieldDidBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isActive = false
        delegate?.textFieldDidEndEditing(textField)
    }
}
