//
//  RegisterTextField.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 10.05.2023.
//

import UIKit

final class RegisterTextField: UITextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    //MARK: - Initializer
    init(placeholder: String){
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    //MARK: - private Method
    private func setupTextField(placeholder: String) {
        textColor = .white
        layer.cornerRadius = 10
        
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 10, height: 10)
        textContentType = .oneTimeCode
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray ])
        font = .boldSystemFont(ofSize: 18)
        
        isSecureTextEntry = true
        
        
    }
}
