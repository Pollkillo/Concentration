//
//  Model.swift
//  Concentration
//
//  Created by Vahe Bazikyan on 10.05.2023.
//

import Foundation


struct User: Codable {
    var name: String
    var surname: String
    var nickname: String
    var age: Int
    var sex: String
    var password: String
    var checkPassword: String
}

struct Users {
    var users: [User]
}
