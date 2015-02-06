//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var filmImageView: PFImageView!
    var film = Film()
    @IBOutlet var middleButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI()
    {
        title = film.title
        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)
    }

    //UICollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCell, forIndexPath: indexPath) as CrewCollectionViewCell
        
        return cell
    }
}
