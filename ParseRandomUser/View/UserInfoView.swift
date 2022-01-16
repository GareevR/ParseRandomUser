//
//  UserInfoView.swift
//  ParseRandomUser
//
//  Created by Ринат Гареев on 14.01.2022.
//

import UIKit

class UserInfoView: UICollectionView {
    
    static let flowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = CGFloat(30)
        collectionViewFlowLayout.minimumInteritemSpacing = CGFloat(10)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
        return collectionViewFlowLayout
    }()
}
