//
//  ViewModelType.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func invokeObservables(input: Input) -> Output
}
