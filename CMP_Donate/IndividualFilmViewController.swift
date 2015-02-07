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
    var theIndexPath = NSIndexPath()
    var synopsisHeight : CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        title = film.title
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

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 180
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kCrewTVCell) as CrewTableViewCell
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier(kSynopsisCell) as SynopsisTableViewCell
            cell.synopsisTextView.text = film.synopsis
            theIndexPath = indexPath
            return cell
        }
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if indexPath.row == 0
        {
            let customCell = cell as CrewTableViewCell
            customCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        if indexPath.row == 1
        {
            return synopsisHeight
        }
        else
        {
            return 120
        }
    }

    @IBAction func onSynopsisTapped(sender: UITapGestureRecognizer)
    {
        if editing == false
        {
            synopsisHeight = 100
            tableView.beginUpdates()
            tableView.endUpdates()
            editing = true
        }
        else
        {
            synopsisHeight = 20
            tableView.beginUpdates()
            tableView.endUpdates()
            editing = false
        }
    }

    //UICollectionView
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return film.productionTeam.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCrewCVCell, forIndexPath: indexPath) as CrewCollectionViewCell
        let crewMember = film.productionTeam[indexPath.row] as CrewMember
        cell.crewLabel.text = crewMember.role + ": " + crewMember.name
        cell.crewImageView.file = crewMember.imageFile
        cell.crewImageView.loadInBackground(nil)
        return cell
    }
}
