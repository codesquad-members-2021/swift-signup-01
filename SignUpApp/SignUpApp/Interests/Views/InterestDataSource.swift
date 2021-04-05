//
//  InterestDataSource.swift
//  SignUpApp
//
//  Created by zombietux on 2021/04/01.
//

import UIKit

class InterestDataSource: NSObject {
    private var interests: InterestsManageable
    
    init(interests: InterestsManageable) {
        self.interests = interests
        super.init()
    }
    
    convenience override init() {
        let interests = Interests()
        self.init(interests: interests)
    }
    
    func count() -> Int {
        return self.interests.count()
    }
    
    func getInterest(at indexPath: IndexPath) -> Interest {
        return self.interests.getInterest(at: indexPath)
    }
}

extension InterestDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InterestCell.identifier, for: indexPath) as? InterestCell else { return UICollectionViewCell() }
        
        let interest = self.getInterest(at: indexPath)
        cell.interestLabel.text = interest.getInterest()
        
        return cell
    }
}
