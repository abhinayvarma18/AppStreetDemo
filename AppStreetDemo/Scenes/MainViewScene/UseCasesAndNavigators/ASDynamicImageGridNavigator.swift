//
//  DynamicImageGridNavigator.swift
//  AppStreetDemo
//
//  Created by Abhinay Varma on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import RxDataSources

//MARK: Protocol for UI update (invoked from)
protocol ASDynamicImageGridNavigator {
    
    func reloadUIOnChangeInSearchResponse(image:UIImage)
    
    func loadFullScreenImage()
}

class DefaultDynamicImageGridNavigator: ASDynamicImageGridNavigator {
    
    //MARK: Properties and VC Initialization
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: ASDynamicImageGridUseCase
    private var viewModel:ASMainVViewModel?
    
    init(services: ASDynamicImageGridUseCase,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    
    //MARK: Stubs of protocol ASDynamicImageGridNavigator
    //MARK: Load Full Screen ImageView
    func loadFullScreenImage() {
        
    }
    
    //MARK: RefreshUi on new search query
    func reloadUIOnChangeInSearchResponse(image: UIImage) {
        let navigator = DefaultDynamicImageGridNavigator(services: services, navigationController: navigationController, storyBoard: UIStoryboard.init(name: "Main", bundle: nil))
        //let viewModel = ASMainVViewModel(useCase: services, navigator: navigator)
        if let mainVC = navigationController.viewControllers.first as? ASMainViewController {
            self.viewModel = mainVC.viewModel
            
        }else{return}
    }
}
