//
//  FlickrCollectionViewController.swift
//  tvOSThreads
//
//  Created by Estefania Guardado on 29/03/2017.
//  Copyright © 2017 Larsecg. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FlickrCollectionViewController: UICollectionViewController {
    
    private var flickr = [FlickrResults]()
    private let connection = FlickrAPIConnection()
    let activityIndicator = UIActivityIndicatorView()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        activityIndicator.color = UIColor.gray
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        
        getFlickrData()
        
    }
    
    func getFlickrData() -> Void {
        connection.getFlickrResourceForTerm("flower"){
            results, error in
            
            self.activityIndicator.removeFromSuperview()
            
            if let error = error {
                print("Error searching : \(error)")
            }
            
            if let results = results {
                print("Found \(results.results.count) matching \(results.term)")
                self.flickr.insert(results, at: 0)
                
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    
    func photoForIndexPath(indexPath: IndexPath) -> FlickrPhoto {
        return flickr[(indexPath as NSIndexPath).section].results[(indexPath as IndexPath).row]
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return flickr.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickr[section].results.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! FlickrPhotoCollectionViewCell
        
        let flickrPhoto = photoForIndexPath(indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        
        cell.flickrPhoto.image = flickrPhoto.thumbnail
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
