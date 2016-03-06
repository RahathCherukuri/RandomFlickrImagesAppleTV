//
//  FlickrCollectionViewController.swift
//  RandomFlickrImagesAppleTV
//
//  Created by Rahath cherukuri on 3/6/16.
//  Copyright © 2016 Rahath cherukuri. All rights reserved.
//

import UIKit

class FlickrCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var flickrCollectionViewOne: UICollectionView!
    
    @IBOutlet weak var flickrCollectionViewTwo: UICollectionView!
    
    var methodArguments = [
        "method": METHOD_NAME,
        "api_key": API_KEY,
        "safe_search": SAFE_SEARCH,
        "extras": EXTRAS,
        "format": DATA_FORMAT,
        "nojsoncallback": NO_JSON_CALLBACK
    ]

    
    override func viewDidLoad() {
        setFirstCollectionView()
        setSecondCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setFirstCollectionView() {
        
        let searchText = "NewYork, NY"
        print("Random Text: ", searchText)
        methodArguments["text"] = searchText
        
        FlickrClient.sharedInstance().getImageFromFlickrBySearch(methodArguments) {(success, photos, errorString) in
            if success {
                FlickrClient.sharedInstance().savePhotoData(photos!, index: 0)
                dispatch_async(dispatch_get_main_queue(), {
                    self.flickrCollectionViewOne.reloadData()
                })
            } else {
                print("Error: ", errorString)
            }
        }
    }
    
    func setSecondCollectionView() {
        let searchText = "Hyderabad, India"
        print("Random Text: ", searchText)
        methodArguments["text"] = searchText
        
        FlickrClient.sharedInstance().getImageFromFlickrBySearch(methodArguments) {(success, photos, errorString) in
            if success {
                FlickrClient.sharedInstance().savePhotoData(photos!,index: 1)
                dispatch_async(dispatch_get_main_queue(), {
                    self.flickrCollectionViewTwo.reloadData()
                })
            } else {
                print("Error: ", errorString)
            }
        }
    }
    
    
    // UICollectionViewDelegate methods
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        if tag == 0 {
            return Data.DataCollectionViewOne.count
        } else {
            return Data.DataCollectionViewTwo.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        
        if tag == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrCollectionViewCellOne", forIndexPath: indexPath) as! FlickrCollectionViewCell
            
            if Data.DataCollectionViewOne.count > 0 {
                let photo = Data.DataCollectionViewOne[indexPath.row]
                
                let imageUrlString = photo.url
                let imageURL = NSURL(string: imageUrlString)
                if let imageData = NSData(contentsOfURL: imageURL!) {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageViewOne.image = UIImage(data: imageData)
                    })
                }
                return cell
            } else {
                return cell
            }
            
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrCollectionViewCellTwo", forIndexPath: indexPath) as! FlickrCollectionViewCell
            
            if Data.DataCollectionViewTwo.count > 0 {
                let photo = Data.DataCollectionViewTwo[indexPath.row]
                
                let imageUrlString = photo.url
                let imageURL = NSURL(string: imageUrlString)
                if let imageData = NSData(contentsOfURL: imageURL!) {
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageViewTwo.image = UIImage(data: imageData)
                    })
                }
                return cell
            } else {
                return cell
            }
            
        }
    }
    
    // Mark: UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did Select indexPath: ", indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        print("In will Display Cell")
        cell.alpha = 0.0
        
        UIView.animateWithDuration(1.0) { () -> Void in
        cell.alpha = 1.0
        }
    }
    
    // Mark: Helper methods.
    
    func getRandomPhotoIndex()-> String {
        let cityStates = ["Hyderabad, India", "Norfolk, VA", "Syracuse, NY", "Banglore, India", "Chennai, India", "Rochester, NY", "NewYork, NY"]
        let randomPhotoIndex = Int(arc4random_uniform(UInt32(cityStates.count)))
        return cityStates[randomPhotoIndex]
    }
    
}




