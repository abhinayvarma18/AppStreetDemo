//
//  ASImageCollectionView.swift
//  AppStreetDemo
//
//  Created by Abhinay Varma on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ASImageCollectionView: UIView {
    let cellIdentifier = "searchResultCollectionImageCell"
    
    var collectionView:UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 160, height: 240)
        
        let imageCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        imageCollectionView.backgroundColor = UIColor.white
        imageCollectionView.collectionViewLayout = layout
        imageCollectionView.backgroundColor = UIColor.white
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.register(ASImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.collectionViewCellIdentifier)
        return imageCollectionView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
	
	override 
    
    func setupCollectionView() {
        self.addSubview(collectionView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]|", options: [], metrics: nil, views: ["collectionView":collectionView]))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
}


//MARK: Handling of CollectionView
extension ASImageCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (self.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: self.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

