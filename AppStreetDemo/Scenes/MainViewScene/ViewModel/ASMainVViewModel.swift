//
//  ASMainViewModel.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//MARK:Extension
protocol DescriptionVCPresentable {
    var searchValue: Variable<String> { get }
}

//MARK:Extension
extension ASMainVViewModel {
    
    struct Input {
        let fetchResponseTriggered: Driver<String>
        let selection: Driver<IndexPath>
		let downloadImage: Driver<URL>
    }
    
    struct Output {
        let cellImageOnClick: Driver<Data>
        let reloadUI: Driver<[ASFlickerImage]>
		let downloadUpcomingModelsDataImage: Driver<Data>
    }
}

class ASMainVViewModel:ViewModelType, DescriptionVCPresentable {
    
    var searchValue: Variable<String> = Variable("")
    
    private let disposeBag = DisposeBag()
    
    private var useCase: ASDynamicImageGridUseCase
    private var navigator: ASDynamicImageGridNavigator
    
    internal var collectionViewDataSource: [ASFlickerImage] = []
	
	
	func invokeObservables(input:Input) -> Output {
		let imageUrlObjects = input.fetchResponseTriggered.flatMapLatest { [weak self](searchString) -> (SharedSequence<DriverSharingStrategy,[ASFlickerImage]>) in
			let searchResultsArray =  self?.useCase.searchResults(searchString: searchString)
			return searchResultsArray!.asDriver { _ in Driver.empty() }
			//return collectionViewDataSource.asDriver { _ in Driver.empty() }
		}
		
		let downloadUpcomingModelsDataImage = input.downloadImage.flatMapLatest {[weak self](urlString) ->
			SharedSequence<DriverSharingStrategy,Data>  in
			 let imageData =  self?.useCase.downloadImage(url: urlString)
			let valueToReturn = imageData?.asDriver { _ in Driver.empty() }
			return valueToReturn!
		}
		
        let moveToDetailViewController = input.selection.flatMapLatest {[weak self] (indexPath) -> SharedSequence<DriverSharingStrategy,Data> in
//			if let imageData = self?.useCase.downloadImage(url: (self?.collectionViewDataSource[indexPath.row].largePhotoUrl)!) {
//				return imageData.asDriver { _ in Driver.empty() }
//			}
			let imageData =  self?.useCase.downloadImage(url: (self?.collectionViewDataSource[indexPath.row].largePhotoUrl!)!)
			let valueToReturn = imageData?.asDriver { _ in Driver.empty() }
			return valueToReturn!
		}
		
		return Output(cellImageOnClick: moveToDetailViewController, reloadUI: imageUrlObjects, downloadUpcomingModelsDataImage: downloadUpcomingModelsDataImage)
    }
    
    init(useCase: ASDynamicImageGridUseCase, navigator: ASDynamicImageGridNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
}
