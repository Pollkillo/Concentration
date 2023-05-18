//
//  Login.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 10.05.2023.
//

import UIKit


class LoginViewController: UIViewController {
    
    //MARK: Private Property
    private let loginTF = RegisterTextField(placeholder: "Login")
    private let passwordTF = RegisterTextField(placeholder: "Password")
    private let eyeButton = EyeButton()
    private let singUpBtn = SignUpButton()
    private var isPrivate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initializeHideKeyboard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShow))
        //Subscribe to a Notification which will fire before the keyboard will hide
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    //MARK: - Private func
    
    
    //MARK: - Action
    @objc func touchEyeButton(){
        let imageName = isPrivate ? "eye" : "eye.slash"
        passwordTF.isSecureTextEntry.toggle()
        eyeButton.setImage(UIImage(systemName: imageName), for: .normal)
        isPrivate.toggle()
    }
    
    @objc func signUpAccount(){
        let registrationVC = Registration()
        navigationController?.pushViewController(registrationVC, animated: true)
        view.endEditing(true)
        //!!! add enter logic
    }
    
    
}

//MARK: - Setting View
private extension LoginViewController {
    
    func setupView(){
        view.backgroundColor = .white
        addSubviews()
        setUpPasswordTF()
        setUpLoginTF()
        addActions()
        setupLayout()
    }
}

//MARK: - Setting
private extension LoginViewController {
    func addSubviews(){
        view.addSubview(loginTF)
        view.addSubview(passwordTF)
        view.addSubview(singUpBtn)
    }
    
    func addActions(){
        eyeButton.addTarget(self, action: #selector(touchEyeButton), for: .touchUpInside)
        singUpBtn.addTarget(self, action: #selector(signUpAccount), for: .touchUpInside)
    }
    
    func setUpPasswordTF(){
        passwordTF.delegate = self
        passwordTF.rightView = eyeButton
        passwordTF.rightViewMode = .always
        passwordTF.tag = 2
    }
    func setUpLoginTF(){
        loginTF.delegate = self
        loginTF.tag = 1
        loginTF.isSecureTextEntry = false
    }
}

//MARK: - Layout
private extension LoginViewController {
    func setupLayout(){
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            loginTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 20),
            passwordTF.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordTF.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        singUpBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            singUpBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            singUpBtn.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            singUpBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        eyeButton.isEnabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

// Keyboard
extension LoginViewController: UIScrollViewDelegate {
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        endEditing()
        
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
