//
//  User.swift
//  ParseRandomUser
//
//  Created by Ринат Гареев on 14.01.2022.
//

import Foundation

// MARK: - User

struct User: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let gender: String
    let name: Name
    let location: Location
    let login: Login
    let dob: DateAge
    let picture: Picture
}

// MARK: - DateAge
struct DateAge: Codable {
    let date: String
    let age: Int
}

// MARK: - Location
struct Location: Codable {
    let city: String
}

// MARK: - Login
struct Login: Codable {
    let username: String
    let password: String
}

// MARK: - Name
struct Name: Codable {
    let first: String
}

// MARK: - Picture
struct Picture: Codable {
    let large: String
}

