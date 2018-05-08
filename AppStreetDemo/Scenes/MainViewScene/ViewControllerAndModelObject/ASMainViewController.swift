//
//  ViewController.swift
//  AppStreetDemo
//
//  Created by AbhinayVarma on 04/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ASMainViewController: UIViewController {
   
    //MARK: Initialization and lifecycle methods
    var viewModel:ASMainVViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ASMainVViewModel(useCase: ASDynamicImageGridUseCase.self as! ASDynamicImageGridUseCase, navigator: ASDynamicImageGridNavigator.self as! ASDynamicImageGridNavigator)
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupNavigationView()
        self.setupCollectionGridView()
    }
    
    
    //MARK: Navigation-Bar
    let customNavigationView:ASNavigationView = {
        let navView = ASNavigationView()
        navView.translatesAutoresizingMaskIntoConstraints = false
        return navView
    }()
    
    private func setupNavigationView() {
        navigationItem.titleView = customNavigationView
    }
    
    
    
    //Mark: Collection View
    let searchResultsCollectionView:ASImageCollectionView = {
        let collectionView = ASImageCollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setupCollectionGridView() {
        
        
    }
    
    
    
    //Mark: Binding of View Components
    func bindViewModel() {
        //Mark: Binding of menu Button
        let menuButtonObservable = customNavigationView.menuButton.rx.tap.asObservable()
             .filter(){ [weak self] searchText -> Bool in
                
                if let searchString = self?.viewModel.searchValue.value,searchString != "" {
                    
                    
                } else {
                    // self.showAlert(msg: "Field Cant be empty")
                    self?.customNavigationView.searchBar.becomeFirstResponder()
                    return false
                }
                return true
              }
              .subscribe { _ in
              }
            
        menuButtonObservable.disposed(by: disposeBag)
        
        //Mark: Binding of collection view
        let collectionViewObservable = Observable
            .just(viewModel.collectionViewDataSource)
            .bind(to: searchResultsCollectionView.collectionView.rx.items)
                { collectionView, row, model in
                    let indexPath = IndexPath(item: row, section: 0)
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath) as? ASImageCollectionViewCell else {
                    fatalError("missing cell")
                }
                cell.bind(model)
                return cell
            }
			collectionViewObservable.disposed(by: disposeBag)
        
		let input = ASMainVViewModel.Input(fetchResponseTriggered: menuButtonObservable as! SharedSequence<DriverSharingStrategy, String>, selection: searchResultsCollectionView.collectionView.rx.itemSelected.asDriver(), downloadImage: collectionViewObservable as! SharedSequence<DriverSharingStrategy, URL>)
        let output = viewModel.invokeObservables(input: input)
        
        
    }
}
