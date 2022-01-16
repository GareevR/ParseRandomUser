//
//  Presenter.swift
//  ParseRandomUser
//
//  Created by Ринат Гареев on 14.01.2022.
//

import Foundation

protocol UserPresenterDelegate: AnyObject {
    func presentUser(user: User)
    func presentUserImage(data: Data)
}

class UserPresenter {
    
    weak var delegate: UserPresenterDelegate?
    
    // Download user info
    
    public func getUser() {
        guard let url = URL(string: "https://randomuser.me/api/") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(User.self, from: data)
                self?.delegate?.presentUser(user: response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    // Download image
    
    public func getImage(imageUrl: String) {
        
        guard let url = URL(string: imageUrl) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("could not load image from URL : \(url)")
                return
            }
            self?.delegate?.presentUserImage(data: data)
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: UserPresenterDelegate) {
        self.delegate = delegate
    }
}
