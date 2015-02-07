//
//  IndividualFilmViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/25/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class IndividualFilmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    var film = Film()
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //UITableView
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 180))
        let filmImageView = PFImageView(frame: CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height))
        filmImageView.contentMode = .ScaleAspectFill
        filmImageView.clipsToBounds = true
        filmImageView.file = film.imageFile
        filmImageView.loadInBackground(nil)
        headerView.addSubview(filmImageView)
        return headerView
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCrewTVCell) as CrewTableViewCell
        return cell
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let customCell = cell as CrewTableViewCell
        customCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
    }

//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        return 135
//    }

    //UICollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCVCell, forIndexPath: indexPath) as CrewCollectionViewCell
        if indexPath.row == 1
        {
            cell.backgroundColor = UIColor.greenColor()
        }
        return cell
    }
//    @IBOutlet var filmImageView: PFImageView!
//    var film = Film()
//    @IBOutlet var middleButton: UIButton!
//    @IBOutlet var collectionView: UICollectionView!
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//        setUpUI()
//
//        var flowlayout = collectionView.collectionViewLayout as UICollectionViewFlowLayout
//        flowlayout.minimumLineSpacing = 0
//    }
//
//    func setUpUI()
//    {
//        title = film.title
//        filmImageView.file = film.imageFile
//        filmImageView.loadInBackground(nil)
//    }
//
//    //UICollectionView
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
//    {
//        return 3
//    }
//
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
//    {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCVCell, forIndexPath: indexPath) as CrewCollectionViewCell
//        if indexPath.row == 0
//        {
//            cell.backgroundColor = UIColor.redColor()
//        }
//        else if indexPath.row == 1
//        {
//            cell.backgroundColor = UIColor.blueColor()
//        }
//        else
//        {
//            cell.backgroundColor = UIColor.greenColor()
//        }
//        return cell
//    }
}
