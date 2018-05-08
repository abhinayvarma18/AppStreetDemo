//
//  ASDynamicImageGridUseCase.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//
import Foundation
import RxSwift

public protocol ASDynamicImageGridUseCase {
    
    //MARK:UseCases functions used to run network calls and immediate ui responses.
    func searchResults(searchString:String) -> Observable<[ASFlickerImage]>
    
    func clickImageResult(indexPath:IndexPath) -> Observable<Void>
    
    func downloadImage(url:URL) -> Observable<Data>
    
    //MARK:3 UIAction
    
}

