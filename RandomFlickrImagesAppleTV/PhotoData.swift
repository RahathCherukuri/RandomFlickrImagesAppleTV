//
//  PhotoData.swift
//  RandomFlickrImagesAppleTV
//
//  Created by Rahath cherukuri on 3/6/16.
//  Copyright © 2016 Rahath cherukuri. All rights reserved.
//

import Foundation

struct photoData {
    
    static var photoArray: [photoData] = []
    
    let title: String
    let url: String
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
        photoData.photoArray.append(self)
    }
}

class Data {
    static var DataCollectionViewOne: [photoData] = []
    static var DataCollectionViewTwo: [photoData] = []
}