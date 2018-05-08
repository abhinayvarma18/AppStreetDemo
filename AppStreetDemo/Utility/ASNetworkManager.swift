//
//  ASNetworkManager.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 05/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

class ASNetworkManager: NSObject {
    
    static let sharedInstance = ASNetworkManager()

    func getImages(tags:String,_ completionHandler:@escaping (ASFlickrImageModel)->()) {
        let baseURL = Constants.flickrUrl
        let apiString = "&api_key=\(Constants.apiKey)"
        let searchString = "&tags=\(tags)&per_page=25&format=json&nojsoncallback=1"
        guard let requestUrl = URL(string: baseURL + apiString + searchString) else {
            return
        }
        let requestURL = URLRequest(url: requestUrl)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: requestURL, completionHandler:{data,response, error -> Void in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let imageData = try decoder.decode(ASFlickrImageModel.self, from: Data(data))
					//self.downloadImage(url: imageData.photos!.photo?.first?.photoUrl, completionHandler)
                    completionHandler(imageData)
                }catch let err {
                    print("Err", err)
                }
            }else {
                return
            }
        })
        task.resume()
    }
    
	func getDataFromUrl(url: URL?, completionHandler:@escaping (Data?) -> ()) {
		guard let url = url else{return completionHandler(nil)}
		URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
			if let data = data, error == nil {
			  completionHandler(data)
			}
			completionHandler(nil)
		}.resume()
    }
    
    func downloadImage(url: URL?, _ completionHandler:@escaping (Data?)->()) {
		if url == nil {
			completionHandler(nil)
		}
		print("Download Started")
		getDataFromUrl(url: url!, completionHandler: { data in
			if let data = data {
				completionHandler(data)
			}else{
				completionHandler(nil)
			}
		})
    }
}
