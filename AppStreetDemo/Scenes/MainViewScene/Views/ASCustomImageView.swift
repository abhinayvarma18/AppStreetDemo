//
//  ASCustomImageView.swift
//  AppStreetDemo
//
//  Created by Sachin Mittal on 06/05/18.
//  Copyright © 2018 Abhinay Varma. All rights reserved.
//

import UIKit

class ASCustomImageView: UIImageView {
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        //Fetching From Cache
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error)
                return
            }
           
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                //Storing
                self.imageCache.setObject(self.imageCache, forKey: urlString as AnyObject)
            }
        }).resume()
    }

}
