//
//  ImageCollectionViewCell.swift
//  AppStreetDemo
//
//  Created by Abhinay Varma on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

class ASImageCollectionViewCell: UICollectionViewCell {
    
    
    
    //MARK:Initialization And ViewLifeCycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    //MARK:Main Image
    var collectionImageView: UIImageView = {
        let cellImage = UIImageView()
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        return cellImage
    }()
   
    //MARK:Default Image
    let thumbnailImageView: ASCustomImageView = {
        let imageView = ASCustomImageView()
        imageView.image = UIImage(named: "thumbnail")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    
    //MARK:Cell Layout Setup
    func setupView() {
        self.addSubview(collectionImageView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionImageCellView]|", options: [], metrics: nil, views: ["collectionImageCellView":collectionImageView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionImageCellView]|", options: [], metrics: nil, views: ["collectionImageCellView":collectionImageView]))
    }
    
    //MARK: Configuring Cell
    func bind(_ viewModel:ASFlickerImage) {
        if let photoData = viewModel.photoData {
            self.collectionImageView.image = UIImage(data: photoData)
        }
    }
}
