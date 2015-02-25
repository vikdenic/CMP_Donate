//
//  FilmCatsViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 2/24/15.
//  Copyright (c) 2015 mobilemakers. All rights reserved.
//

import UIKit

class FilmCatsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()

        Event.queryAllEvents { (theEvents, error) -> Void in
            self.events = theEvents
            self.collectionView.reloadData()
        }
    }

    //UICollectionView
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCatCell, forIndexPath: indexPath) as CategoryCollectionViewCell
        let event = events[indexPath.row]
        cell.categoryLabel.text = event.name
        cell.categoryLabel.sizeToFit()
        cell.categoryImageView.file = event.imageFile
        cell.categoryImageView.loadInBackground(nil)
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return events.count
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(12, 12, 12, 12)
    }

    //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    }
}
