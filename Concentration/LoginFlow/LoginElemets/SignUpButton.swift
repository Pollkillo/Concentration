//
//  CreateAccountButton.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 11.05.2023.
//

import UIKit

class SignUpButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sighUpBtn()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sighUpBtn(){
        setTitle("Sign Up", for: .normal)
        tintColor = .white
        backgroundColor = .lightGray
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 10, height: 10)
        isEnabled = true
    }
    
}
