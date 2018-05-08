//
//  ASNavigationView.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 04/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ASNavigationView: UIView {
    
    lazy var searchBar:UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        searchbar.placeholder = "Search Image"
        return searchbar
    }()
    
    lazy var menuButton:UIButton = {
        let menu = UIButton()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.setBackgroundImage(UIImage(named:"menuIcon"), for: .normal)
       // menu.setImage(UIImage(named:"menuIcon"), for: .normal)
        return menu
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
       let viewDict:[String:Any] = ["searchBar":searchBar, "menuButton":menuButton]
        
       self.addSubview(searchBar)
       self.addSubview(menuButton)
        
       self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchBar]-(10)-[menuButton(==40)]|", options: [], metrics: nil, views: viewDict))
       self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[searchBar]|", options: [], metrics: nil, views: viewDict))
       self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[menuButton]|", options: [], metrics: nil, views: viewDict))
    }
    
}
