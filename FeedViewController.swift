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

    //View Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewDidAppear(animated: Bool)
    {
        //Using selector after view has appeared suppresses "detached view controllers" warning related to modal segue
        var timer = NSTimer.scheduledTimerWithTimeInterval(0, target: self, selector: "decideIfLoggedIn", userInfo: nil, repeats: false)
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
            Profile.queryForCurrentUserProfile({ (profile, error) -> Void in
                UniversalProfile.sharedInstance.profile = profile
            })
            self.setFilmData()
        }
    }

    func setFilmData()
    {
        Film.queryAllFilms({ (films, error) -> Void in
            self.filmsArray = films as [Film]
            self.tableView.reloadData()
        })
    }

    //UITableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell") as FeedTableViewCell
        let film = filmsArray[indexPath.row] as Film
        cell.titleLabel.text = film.title
        cell.filmImageView.file = film.imageFile
        cell.filmImageView.loadInBackground(nil)
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
