//
//  FeedViewController.swift
//  CMP_Donate
//
//  Created by Vik Denic on 1/24/15.
//  Copyright (c) 2015 Chicago Media Project. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var filmsArray = [Film]()
    var fromCategory = Bool()
    var event = Event()

    @IBOutlet var segmentedControl: UISegmentedControl!

    //View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Featured"

        if fromCategory == true
        {
            adjustUIForCategory()
        }
    }

    override func viewDidAppear(animated: Bool)
    {
        //Using selector after view has appeared suppresses "detached view controllers" warning related to modal segue
        var timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: "decideIfLoggedIn", userInfo: nil, repeats: false)

//        navigationController?.resetNavBar()

        navigationController?.resetNavBar()
        navigationController?.navigationBarHidden = true
        navigationController?.navigationBarHidden = false
    }

    //Helper
    func decideIfLoggedIn()
    {
        if PFUser.currentUser() == nil
        {
            performSegueWithIdentifier(kFeedToRegisterSegue, sender: self)
        }
        else
        {
            self.setFilmData()
        }
    }

    func setFilmData()
    {
        if fromCategory == false
        {
            Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
                UniversalProfile.sharedInstance.profile = profile
            })

            Film.queryAllFilms({ (films, error) -> Void in
                self.filmsArray = films as [Film]
                self.tableView.reloadData()
            })
        }
        else
        {
            Film.queryAllFilms(event, completed: { (films, error) -> Void in
                self.filmsArray = films as [Film]
                self.tableView.reloadData()
            })
        }
    }

    func adjustUIForCategory()
    {
        title = event.name
        navigationItem.rightBarButtonItem = nil
    }

    //UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as FeedTableViewCell
        let film = filmsArray[indexPath.row] as Film
        cell.titleLabel.text = film.title
        cell.filmImageView.file = film.imageFile

        //if the data isn't in memory, animate it in from nothing
        if film.imageFile.isDataAvailable == false
        {
            cell.filmImageView.alpha = 0
            cell.filmImageView.loadInBackground { (image, error) -> Void in
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    cell.filmImageView.alpha = 1;
                })
            }
        }
        else //fail safe
        {
            cell.filmImageView.loadInBackground(nil) //just grabs it from the file system
        }
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filmsArray.count
    }

    //Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == kFeedToIndividualFilmSegue
        {
            let individualFilmVC = segue.destinationViewController as IndividualFilmViewController
            individualFilmVC.film = filmsArray[tableView.indexPathForSelectedRow()!.row]
        }
    }
}
