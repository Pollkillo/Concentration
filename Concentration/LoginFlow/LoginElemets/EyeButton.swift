//
//  EyeButton.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 10.05.2023.
//

import UIKit

final class EyeButton: UIButton {
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpEyeButton()
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpEyeButton(){
        setImage(UIImage(systemName: "eye.slash"), for: .normal)
        tintColor = .white
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        isEnabled = false
    }
}
