//
//  ASFlickrImages.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

public struct ASFlickrImageModel: Encodable, Decodable {
   public let photos : ASFlickerImages?
}

public struct ASFlickerImages: Encodable, Decodable {
   public let photo:[ASFlickerImage]? = []
}

//MARK:Image Object
public struct ASFlickerImage:Codable {
    public let id:String?
    public let secret:String?
    public let farm:Int?
    public let server:String?
    
    public init (with model:ASFlickerImage) {
        self.id = model.id
        self.secret = model.secret
        self.server = model.server
        self.farm = model.farm
    }
    
    public var photoData:Data?
    public var largePhotoData:Data?
    
}


//MARK:Image Urls(High and medium resolution)
extension ASFlickerImage:Equatable {
    var photoUrl: URL? {
        return URL(string: "http://farm\(farm ?? 0).staticflickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? ""))_m.jpg")
    }
    
    var largePhotoUrl: URL? {
        return URL(string: "http://farm\(farm ?? 0).staticflickr.com/\(server ?? "")/\(id ?? "")_\(secret ?? "")_m.jpg")
    }
    
    public static func == (lhs: ASFlickerImage, rhs: ASFlickerImage) -> Bool {
        return lhs.id == rhs.id
    }
    
}
