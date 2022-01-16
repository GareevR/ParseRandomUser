//
//  UserView.swift
//  ParseRandomUser
//
//  Created by Ринат Гареев on 14.01.2022.

import UIKit

class UserViewController: UIViewController, UserPresenterDelegate {
    
    private var safeArea: UILayoutGuide!
    
    private var userInfoView = UserInfoView(frame: .zero, collectionViewLayout: UserInfoView.flowLayout)
    private var userPhotoView = UIImageView()
    
    private let presenter = UserPresenter()
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        
        setupNavigationBar()
        setupUserInfoView()
        setupImageView()
        presenter.setViewDelegate(delegate: self)
        DispatchQueue.global(qos: .background).async {
            self.presenter.getUser()
        }
    }
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = "FakeUser"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadPage))
    }
    
    @objc func reloadPage() {
        DispatchQueue.global(qos: .background).async {
            self.presenter.getUser()
        }
    }
    
    func setupImageView() {
        
        view.addSubview(userPhotoView)
        
        userPhotoView.translatesAutoresizingMaskIntoConstraints = false
        userPhotoView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        userPhotoView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        userPhotoView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        userPhotoView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        userPhotoView.contentMode = .scaleAspectFit
    }
    
    func setupUserInfoView() {
        
        view.addSubview(userInfoView)
        
        userInfoView.register(UserInfoViewCell.self, forCellWithReuseIdentifier: "cell-id")
        userInfoView.delegate = self
        userInfoView.dataSource = self
        
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.topAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        userInfoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        userInfoView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        userInfoView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
    }
    
    // Presenter Delegate
    
    func presentUser(user: User) {
        self.user = user
        DispatchQueue.global(qos: .background).async {
            self.presenter.getImage(imageUrl: self.user!.results[0].picture.large)
            DispatchQueue.main.async {
                self.userInfoView.reloadData()
            }
        }
    }
    
    func presentUserImage(data: Data) {
        guard let newImage = UIImage(data: data) else {
            return
        }
        DispatchQueue.main.async {
            self.userPhotoView.image = newImage
        }
    }
}

// Collection View

extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-id", for: indexPath)
        
        guard let userInfoCell = cell as? UserInfoViewCell, let user = user else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            userInfoCell.setValues(key: "Name:", value: user.results[0].name.first)
        case 1:
            userInfoCell.setValues(key: "Gender:", value: user.results[0].gender)
        case 2:
            userInfoCell.setValues(key: "Username:", value: user.results[0].login.username)
        case 3:
            userInfoCell.setValues(key: "Age:", value: String(user.results[0].dob.age))
        case 4:
            userInfoCell.setValues(key: "Password:", value: user.results[0].login.password)
        case 5:
            userInfoCell.setValues(key: "City:", value: user.results[0].location.city)
        default:
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width;
        let height = view.frame.height;
        
        if width < height {
            return CGSize(width: width / 2 - 10, height: height / 9)
        }
        return CGSize(width: width / 4, height: height / 5)
    }
}
